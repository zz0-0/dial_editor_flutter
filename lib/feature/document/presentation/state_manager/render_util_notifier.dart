import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:dial_editor_flutter/share/provider/document/presentation/state_manager/inline_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RenderUtilNotifier extends Notifier<void> {
  @override
  void build() {
    return;
  }

  Text render(BuildContext context, Inline inline) {
    final newTextStyle = _getTextStyle(inline);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(inlineProvider(inline.key).notifier)
          .updateTextStyle(newTextStyle);
      ref.read(inlineProvider(inline.key).notifier).updateHeight(context);
    });

    return Text(
      inline.text,
      style: newTextStyle,
    );
  }

  TextStyle _getTextStyle(Inline inline) {
    const baseStyle = TextStyle(
      fontSize: 16,
    );

    switch (inline.runtimeType) {
      case Bold:
        return baseStyle.copyWith(fontWeight: FontWeight.bold);

      case Italic:
        return baseStyle.copyWith(fontStyle: FontStyle.italic);

      case BoldItalic:
        return baseStyle.copyWith(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        );

      case Heading:
        final heading = inline as Heading;
        final sizes = {
          1: 32.0,
          2: 28.0,
          3: 24.0,
          4: 20.0,
          5: 18.0,
          6: 16.0,
        };
        return baseStyle.copyWith(
          fontSize: sizes[heading.level],
          fontWeight: FontWeight.bold,
        );

      case Strikethrough:
        return baseStyle.copyWith(
          decoration: TextDecoration.lineThrough,
        );

      case Link:
        return baseStyle.copyWith(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        );

      case Highlight:
        return baseStyle.copyWith(
          backgroundColor: Colors.yellow,
        );

      case Subscript:
        return baseStyle.copyWith(
          fontSize: baseStyle.fontSize! * 0.75,
        );

      case Superscript:
        return baseStyle.copyWith(
          fontSize: baseStyle.fontSize! * 0.75,
        );

      case Math:
        return baseStyle.copyWith(
          fontFamily: 'Courier New',
        );

      case Quote:
        return baseStyle.copyWith(
          fontStyle: FontStyle.italic,
          color: Colors.grey[700],
        );

      case UnorderedListNode:
      case OrderedListNode:
        return baseStyle;

      case TaskListNode:
        return baseStyle;

      case CodeBlockMarker:
      case CodeLine:
        return baseStyle.copyWith(
          fontFamily: 'Courier New',
          backgroundColor: Colors.grey[200],
        );

      case HorizontalRule:
        return baseStyle;

      case ImageNode:
        return baseStyle;

      default:
        return baseStyle;
    }
  }
}