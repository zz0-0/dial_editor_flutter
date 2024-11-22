import 'package:dial_editor_flutter/feature/document/domain/model/element/inline.dart';
import 'package:dial_editor_flutter/feature/document/domain/model/element/inline/heading.dart';
import 'package:dial_editor_flutter/feature/document/domain/model/element/inline/text_node.dart';
import 'package:dial_editor_flutter/share/provider/document/presentation/state_manager/inline_list_async_notifier_provider.dart';
import 'package:dial_editor_flutter/share/provider/document/presentation/state_manager/inline_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InlineNotifier extends FamilyNotifier<Inline, GlobalKey> {
  @override
  Inline build(GlobalKey arg) {
    return TextNode(key: arg, text: '');
  }

  // ignore: use_setters_to_change_properties
  void initialize(Inline inline) {
    state = inline;
  }

  // for all the methods below, the reason why include
  // index is to make sure the state is updated correctly.
  // riverpod will not update the state if the object is not changed
  // however, if the new inline is created, the linked list's connection
  // will be broken, therefore, the index is needed to make sure the
  // new inline is reconnected to the linked list correctly.
  void updateToEditngMode() {
    // resetAllToDisplayMode();
    state = state.copyWith(isEditing: true)..focusNode.requestFocus();
  }

  void updateToDisplayMode() {
    state = state.copyWith(isEditing: false)..focusNode.unfocus();
  }

  void resetAllToDisplayMode() {
    final inlineLinkedList = state.list;
    for (var i = 0; i < inlineLinkedList!.length; i++) {
      if (inlineLinkedList.elementAt(i) == state) {
        continue;
      }
      state = inlineLinkedList.elementAt(i).copyWith(isEditing: false);
    }
  }

  void updateTextStyle(TextStyle textStyle) {
    state = state.copyWith(textStyle: textStyle);
  }

  void updateHeight(BuildContext context) {
    final inline = state;
    final text = inline.textController.text;
    final style = inline.textStyle;
    final maxWidth = MediaQuery.of(context).size.width;
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    final newLineHeight = textPainter.height;
    if (inline.lineHeight != newLineHeight) {
      state = inline.copyWith(
        lineHeight: newLineHeight,
      );
    }
  }

  void updateExpanded({required bool isExpanded}) {
    state = state.copyWith(isExpanded: isExpanded);
  }

  void updateCursorOffset(int cursorOffset) {
    state =
        state.copyWith(baseOffset: cursorOffset, extentOffset: cursorOffset);
  }

  void updateBaseOffset(int baseOffset) {
    state = state.copyWith(baseOffset: baseOffset);
  }

  void updateExtentOffset(int extentOffset) {
    state = state.copyWith(extentOffset: extentOffset);
  }

  // base on the heading level, larger level means deeper nested level
  // which can be expanded or collapsed by upper level
  void toggleExpand() {
    final toggleLevel = state.level;
    ref.read(toggleLevelProvider.notifier).state = toggleLevel;
    var index = 0;
    state.isExpanded = !state.isExpanded;
    updateExpanded(isExpanded: state.isExpanded);
    final inlineLinkedList = state.list;
    for (var i = 0; i < inlineLinkedList!.length; i++) {
      if (state == inlineLinkedList.elementAt(i)) {
        index = i;
        break;
      }
    }
    for (var i = index + 1; i < inlineLinkedList.length; i++) {
      if ((inlineLinkedList.elementAt(i).level <= toggleLevel &&
              inlineLinkedList.elementAt(i) is Heading) ||
          inlineLinkedList.elementAt(i).level < toggleLevel) {
        break;
      }
      inlineLinkedList.elementAt(i).isExpanded = state.isExpanded;
      ref
          .read(inlineProvider(inlineLinkedList.elementAt(i).key).notifier)
          .updateExpanded(isExpanded: inlineLinkedList.elementAt(i).isExpanded);
    }
  }

  void selectAll() {}

  Future<void> onDelete() async {
    if (state.text.isEmpty) {
      if (state.previous != null) {
        final previous = state.previous!;
        ref.read(inlineProvider(previous.key).notifier).updateToEditngMode();
        await ref.read(inlineListProvider.notifier).removeInline(state);
      }
    }
  }

  Future<void> onSubmit() async {
    final newLine = state.createNewLine();
    ref.read(inlineProvider(newLine.key).notifier).initialize(newLine);
    await ref.read(inlineListProvider.notifier).createNewLine(state, newLine);
    ref.read(inlineProvider(newLine.key).notifier).updateToEditngMode();
  }

  void onArrowUp() {
    if (state.previous != null) {
      ref
          .read(inlineProvider(state.previous!.key).notifier)
          .updateToEditngMode();
      ref.read(inlineProvider(state.key).notifier).updateToDisplayMode();
    }
  }

  void onArrowDown() {
    if (state.next != null) {
      ref.read(inlineProvider(state.next!.key).notifier).updateToEditngMode();
      ref.read(inlineProvider(state.key).notifier).updateToDisplayMode();
    }
  }

  void onArrowLeft({required bool isShiftPressed}) {
    if (state.textController.selection.extentOffset == 0) {
      if (state.previous != null) {
        ref
            .read(inlineProvider(state.previous!.key).notifier)
            .updateToEditngMode();
        ref.read(inlineProvider(state.key).notifier).updateToDisplayMode();
      }
    }
  }

  void onArrowRight({required bool isShiftPressed}) {
    if (state.textController.selection.extentOffset ==
        state.textController.text.length) {
      if (state.next != null) {
        ref
            .read(inlineProvider(state.next!.key).notifier)
            .updateCursorOffset(0);
        ref.read(inlineProvider(state.next!.key).notifier).updateToEditngMode();
        ref.read(inlineProvider(state.key).notifier).updateToDisplayMode();
      }
    }
  }
}
