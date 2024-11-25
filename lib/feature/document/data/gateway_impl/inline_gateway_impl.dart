import 'dart:collection';

import 'package:dial_editor_flutter/feature/document/domain/gateway/gateway/inline_gateway.dart';
import 'package:dial_editor_flutter/feature/document/domain/model/element.dart';
import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:dial_editor_flutter/share/uuid.dart';

class InlineGatewayImpl implements InlineGateway {
  OrderedListBlock? currentOrderedListBlock;
  TaskListBlock? currentTaskListBlock;
  UnorderedListBlock? currentUnorderedListBlock;
  CodeBlock? currentCodeBlock;
  HeadingBlock? currentHeadingBlock;
  MathBlock? currentMathBlock;
  QuoteBlock? currentQuoteBlock;
  TableBlock? currentTableBlock;

  int level = 1;

  @override
  Document convertToDocument(List<String> lines) {
    final linkedInlines = LinkedList<Inline>();
    for (final line in lines) {
      final inline = convert(line);
      _setCurrentLevel(inline);
      _setBlockStart(inline);
      linkedInlines.add(inline);
    }
    final elementId = ElementId(uuid.v4(), ElementType.document);
    return Document(id: elementId, inlines: linkedInlines);
  }

  @override
  Inline convert(String line) {
    final elementId = ElementId(uuid.v4(), ElementType.inline);
    final patterns = [
      (
        MarkdownPattern.headingRegex,
        (String line) {
          final match = MarkdownPattern.customIdHeadingRegex.firstMatch(line)!;
          final level = match.group(1)!.length;
          final content = match.group(2)!;
          return Heading(
            id: elementId,
            text: line,
            renderText: content,
          )
            ..level = level
            ..isBlockStart = true;
        }
      ),
      (
        MarkdownPattern.boldItalicRegex,
        (String line) {
          final match = MarkdownPattern.boldItalicRegex.firstMatch(line)!;
          final content = match.group(2)!;
          return BoldItalic(
            id: elementId,
            text: line,
            renderText: content,
          );
        }
      ),
      (
        MarkdownPattern.boldRegex,
        (String line) {
          final match = MarkdownPattern.boldRegex.firstMatch(line)!;
          final content = match.group(2)!;
          return Bold(
            id: elementId,
            text: line,
            renderText: content,
          );
        }
      ),
      (
        MarkdownPattern.italicRegex,
        (String line) {
          final match = MarkdownPattern.italicRegex.firstMatch(line)!;
          final content = match.group(2)!;
          return Italic(
            id: elementId,
            text: line,
            renderText: content,
          );
        }
      ),
      (
        MarkdownPattern.unorderedListRegex,
        (String line) {
          return UnorderedListNode(
            id: elementId,
            text: line,
            renderText: line,
          );
        }
      ),
      (
        MarkdownPattern.orderListRegex,
        (String line) {
          return OrderedListNode(
            id: elementId,
            text: line,
            renderText: line,
          );
        }
      ),
      (
        MarkdownPattern.taskListRegex,
        (String line) {
          return TaskListNode(
            id: elementId,
            text: line,
            renderText: line,
          );
        }
      ),
      (
        MarkdownPattern.strikethroughRegex,
        (String line) {
          final match = MarkdownPattern.strikethroughRegex.firstMatch(line)!;
          final content = match.group(1)!;
          return Strikethrough(
            id: elementId,
            text: line,
            renderText: content,
          );
        }
      ),
      (
        MarkdownPattern.imageRegex,
        (String line) {
          final match = MarkdownPattern.imageRegex.firstMatch(line)!;
          final altText = match.group(1)!;
          return ImageNode(
            id: elementId,
            text: line,
            renderText: altText,
          );
        }
      ),
      (
        MarkdownPattern.linkRegex,
        (String line) {
          final match = MarkdownPattern.linkRegex.firstMatch(line)!;
          final linkText = match.group(1)!;
          return Link(
            id: elementId,
            text: line,
            renderText: linkText,
          );
        }
      ),
      (
        MarkdownPattern.highlightRegex,
        (String line) {
          final match = MarkdownPattern.highlightRegex.firstMatch(line)!;
          final content = match.group(1)!;
          return Highlight(
            id: elementId,
            text: line,
            renderText: content,
          );
        }
      ),
      (
        MarkdownPattern.subscriptRegex,
        (String line) {
          return Subscript(
            id: elementId,
            text: line,
            renderText: line,
          );
        }
      ),
      (
        MarkdownPattern.superscriptRegex,
        (String line) {
          return Superscript(
            id: elementId,
            text: line,
            renderText: line,
          );
        }
      ),
      (
        MarkdownPattern.horizontalRuleRegex,
        (String line) {
          return HorizontalRule(
            id: elementId,
            text: line,
            renderText: '---',
          );
        }
      ),
      (
        MarkdownPattern.inlineMathRegex,
        (String line) {
          return Math(
            id: elementId,
            text: line,
            renderText: line,
          );
        }
      ),
      // (
      //   MarkdownPattern.blockMathRegex,
      //   (String line) {
      //     final match = MarkdownPattern.blockMathRegex.firstMatch(line)!;
      //     return BlockMath(text: match.group(1)!);
      //   }
      // ),
      (
        MarkdownPattern.codeBlockRegex,
        (String line) {
          final language = line.substring(3).trim();
          return CodeBlockMarker(
            id: elementId,
            text: line,
            renderText: '```$language',
            isCodeBlockStartMarker: language.isNotEmpty,
          );
        }
      ),
      (
        MarkdownPattern.quoteRegex,
        (String line) {
          return Quote(
            id: elementId,
            text: line,
            renderText: line,
          );
        }
      ),
      (
        MarkdownPattern.tableHeaderRegex,
        (String line) {
          return TableHeader(
            id: elementId,
            text: line,
            renderText: line,
          );
        }
      ),
      (
        MarkdownPattern.tableLineRegex,
        (String line) {
          return TableLine(
            id: elementId,
            text: line,
            renderText: line,
          );
        }
      ),
    ];

    for (final (pattern, builder) in patterns) {
      if (pattern.hasMatch(line)) {
        return builder(line);
      }
    }
    return TextNode(
      id: elementId,
      text: line,
      renderText: line,
    );
  }

  void _setCurrentLevel(Inline inline) {
    if (inline is Heading) {
      level = inline.level;
    } else {
      inline.level = level + 1;
    }
  }

  void _setBlockStart(Inline inline) {
    final elementId = ElementId(uuid.v4(), ElementType.inline);
    if (inline is OrderedListNode) {
      if (currentOrderedListBlock == null) {
        inline.isBlockStart = true;
        currentOrderedListBlock =
            OrderedListBlock(id: elementId, level: inline.level + 1);
      }
      inline.level = inline.level + 1;
    } else if (inline is TaskListNode) {
      if (currentTaskListBlock == null) {
        inline.isBlockStart = true;
        currentTaskListBlock =
            TaskListBlock(id: elementId, level: inline.level + 1);
      }
      inline.level = inline.level + 1;
    } else if (inline is UnorderedListNode) {
      if (currentUnorderedListBlock == null) {
        inline.isBlockStart = true;
        currentUnorderedListBlock =
            UnorderedListBlock(id: elementId, level: inline.level + 1);
      }
      inline.level = inline.level + 1;
    } else if (inline is CodeBlockMarker) {
      if (currentCodeBlock == null) {
        inline.isBlockStart = true;
        currentCodeBlock = CodeBlock(id: elementId, level: inline.level + 1);
      }
      inline.level = inline.level + 1;
    } else if (inline is Math) {
      if (currentMathBlock == null) {
        inline.isBlockStart = true;
        currentMathBlock = MathBlock(id: elementId, level: inline.level + 1);
      }
      inline.level = inline.level + 1;
    } else if (inline is Quote) {
      if (currentQuoteBlock == null) {
        inline.isBlockStart = true;
        currentQuoteBlock = QuoteBlock(id: elementId, level: inline.level + 1);
      }
      inline.level = inline.level + 1;
    } else if (inline is TableHeader) {
      if (currentTableBlock == null) {
        inline.isBlockStart = true;
        currentTableBlock = TableBlock(id: elementId, level: inline.level + 1);
      }
      inline.level = inline.level + 1;
    } else {
      if (inline is! Heading) {
        currentCodeBlock = null;
        currentMathBlock = null;
        currentOrderedListBlock = null;
        currentTaskListBlock = null;
        currentUnorderedListBlock = null;
        currentQuoteBlock = null;
        currentTableBlock = null;
      }
    }
  }
}
