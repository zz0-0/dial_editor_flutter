import 'dart:collection';

import 'package:dial_editor_flutter/feature/document/domain/gateway/gateway/inline_gateway.dart';
import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:flutter/material.dart';

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
    return Document(inlines: linkedInlines);
  }

  @override
  Inline convert(String line) {
    final key = GlobalKey();
    final patterns = [
      (
        MarkdownPattern.headingRegex,
        (String line) {
          final match = MarkdownPattern.customIdHeadingRegex.firstMatch(line)!;
          final level = match.group(0)!.length;
          return Heading(
            key: key,
            text: line,
          )
            ..level = level
            ..isBlockStart = true;
        }
      ),
      (
        MarkdownPattern.boldItalicRegex,
        (String line) {
          return BoldItalic(
            text: line,
            key: key,
          );
        }
      ),
      (
        MarkdownPattern.boldRegex,
        (String line) {
          return Bold(
            key: key,
            text: line,
          );
        }
      ),
      (
        MarkdownPattern.italicRegex,
        (String line) {
          return Italic(
            key: key,
            text: line,
          );
        }
      ),
      (
        MarkdownPattern.unorderedListRegex,
        (String line) {
          return UnorderedListNode(
            key: key,
            text: line,
          );
        }
      ),
      (
        MarkdownPattern.orderListRegex,
        (String line) {
          return OrderedListNode(
            text: line,
            key: key,
          );
        }
      ),
      (
        MarkdownPattern.taskListRegex,
        (String line) {
          return TaskListNode(
            key: key,
            text: line,
          );
        }
      ),
      (
        MarkdownPattern.strikethroughRegex,
        (String line) {
          return Strikethrough(
            key: key,
            text: line,
          );
        }
      ),
      (
        MarkdownPattern.imageRegex,
        (String line) {
          return ImageNode(
            text: line,
            key: key,
          );
        }
      ),
      (
        MarkdownPattern.linkRegex,
        (String line) {
          return Link(
            key: key,
            text: line,
          );
        }
      ),
      (
        MarkdownPattern.highlightRegex,
        (String line) {
          return Highlight(
            key: key,
            text: line,
          );
        }
      ),
      (
        MarkdownPattern.subscriptRegex,
        (String line) {
          return Subscript(
            key: key,
            text: line,
          );
        }
      ),
      (
        MarkdownPattern.superscriptRegex,
        (String line) {
          return Superscript(
            key: key,
            text: line,
          );
        }
      ),
      (
        MarkdownPattern.horizontalRuleRegex,
        (String line) {
          return HorizontalRule(
            key: key,
            text: line,
          );
        }
      ),
      (
        MarkdownPattern.inlineMathRegex,
        (String line) {
          return Math(
            key: key,
            text: line,
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
            key: key,
            text: line,
            isCodeBlockStartMarker: language.isNotEmpty,
          );
        }
      ),
      (
        MarkdownPattern.quoteRegex,
        (String line) {
          return Quote(text: line.substring(1).trim(), key: key);
        }
      ),
      (
        MarkdownPattern.tableHeaderRegex,
        (String line) {
          return TableHeader(
            key: key,
            text: line,
          );
        }
      ),
      (
        MarkdownPattern.tableLineRegex,
        (String line) {
          return TableLine(
            key: key,
            text: line,
          );
        }
      ),
    ];

    for (final (pattern, builder) in patterns) {
      if (pattern.hasMatch(line)) {
        return builder(line)
          ..renderText =
              line.replaceAllMapped(pattern, (match) => match.group(0)!);
      }
    }
    return TextNode(
      key: key,
      text: line,
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
    if (inline is OrderedListNode) {
      if (currentOrderedListBlock == null) {
        inline.isBlockStart = true;
        currentOrderedListBlock =
            OrderedListBlock(key: GlobalKey(), level: inline.level + 1);
      }
      inline.level = inline.level + 1;
    } else if (inline is TaskListNode) {
      if (currentTaskListBlock == null) {
        inline.isBlockStart = true;
        currentTaskListBlock =
            TaskListBlock(key: GlobalKey(), level: inline.level + 1);
      }
      inline.level = inline.level + 1;
    } else if (inline is UnorderedListNode) {
      if (currentUnorderedListBlock == null) {
        inline.isBlockStart = true;
        currentUnorderedListBlock =
            UnorderedListBlock(key: GlobalKey(), level: inline.level + 1);
      }
      inline.level = inline.level + 1;
    } else if (inline is CodeBlockMarker) {
      if (currentCodeBlock == null) {
        inline.isBlockStart = true;
        currentCodeBlock = CodeBlock(key: GlobalKey(), level: inline.level + 1);
      }
      inline.level = inline.level + 1;
    } else if (inline is Math) {
      if (currentMathBlock == null) {
        inline.isBlockStart = true;
        currentMathBlock = MathBlock(key: GlobalKey(), level: inline.level + 1);
      }
      inline.level = inline.level + 1;
    } else if (inline is Quote) {
      if (currentQuoteBlock == null) {
        inline.isBlockStart = true;
        currentQuoteBlock =
            QuoteBlock(key: GlobalKey(), level: inline.level + 1);
      }
      inline.level = inline.level + 1;
    } else if (inline is TableHeader) {
      if (currentTableBlock == null) {
        inline.isBlockStart = true;
        currentTableBlock =
            TableBlock(key: GlobalKey(), level: inline.level + 1);
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
