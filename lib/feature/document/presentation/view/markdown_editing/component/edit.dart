import 'package:dial_editor_flutter/feature/document/presentation/state_manager/inline_notifier.dart';
import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:dial_editor_flutter/share/provider/document/presentation/state_manager/inline_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Edit extends ConsumerStatefulWidget {
  const Edit({required this.inline, super.key});

  final Inline inline;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditState();
}

class _EditState extends ConsumerState<Edit> {
  late InlineNotifier inlineNotifier;

  @override
  Widget build(BuildContext context) {
    inlineNotifier = ref.read(inlineProvider(widget.inline.key).notifier);
    return Focus(
      onKeyEvent: (node, event) => _onKeyEvent(event, widget.inline),
      child: SizedBox(
        height: widget.inline.lineHeight,
        child: EditableText(
          controller: widget.inline.textController,
          focusNode: widget.inline.focusNode,
          style: widget.inline.textStyle,
          cursorColor: Colors.blue,
          backgroundCursorColor: Colors.blue,
          selectionColor: Colors.red,
          onChanged: (value) => _onChnage(value, widget.inline),
          onSubmitted: (value) => _onSubmit(value, widget.inline),
        ),
      ),
    );
  }

  KeyEventResult _onKeyEvent(KeyEvent event, Inline inline) {
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.keyA &&
        HardwareKeyboard.instance.isControlPressed) {
      _selectAll();
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      _onDelete();
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _onArrowUp();
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _onArrowDown();
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      _onArrowLeft(HardwareKeyboard.instance.isShiftPressed);
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowRight) {
      _onArrowRight(HardwareKeyboard.instance.isShiftPressed);
    }
    return KeyEventResult.ignored;
  }

  void _onChnage(String value, Inline inline) {
    inline.text = value;
  }

  void _onSubmit(String value, Inline inline) {
    inlineNotifier.onSubmit();
  }

  void _selectAll() {
    inlineNotifier.selectAll();
  }

  void _onDelete() {
    inlineNotifier.onDelete();
  }

  void _onArrowUp() {
    inlineNotifier.onArrowUp();
  }

  void _onArrowDown() {
    inlineNotifier.onArrowDown();
  }

  void _onArrowLeft(bool isShiftPressed) {
    inlineNotifier.onArrowLeft(isShiftPressed: isShiftPressed);
  }

  void _onArrowRight(bool isShiftPressed) {
    inlineNotifier.onArrowRight(isShiftPressed: isShiftPressed);
  }
}
