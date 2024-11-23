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
      print(inline.renderText);
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
          final level = match.group(1)!.length;
          final content = match.group(2)!;
          return Heading(
            key: key,
            text: line,
          )
            ..renderText = content
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
            key: key,
            text: line,
          )..renderText = content;
        }
      ),
      (
        MarkdownPattern.boldRegex,
        (String line) {
          final match = MarkdownPattern.boldRegex.firstMatch(line)!;
          final content = match.group(2)!;
          return Bold(
            key: key,
            text: line,
          )..renderText = content;
        }
      ),
      (
        MarkdownPattern.italicRegex,
        (String line) {
          final match = MarkdownPattern.italicRegex.firstMatch(line)!;
          final content = match.group(2)!;
          return Italic(
            key: key,
            text: line,
          )..renderText = content;
        }
      ),
      (
        MarkdownPattern.unorderedListRegex,
        (String line) {
          return UnorderedListNode(
            key: key,
            text: line,
          )..renderText = line;
        }
      ),
      (
        MarkdownPattern.orderListRegex,
        (String line) {
          return OrderedListNode(
            key: key,
            text: line,
          )..renderText = line;
        }
      ),
      (
        MarkdownPattern.taskListRegex,
        (String line) {
          return TaskListNode(
            key: key,
            text: line,
          )..renderText = line;
        }
      ),
      (
        MarkdownPattern.strikethroughRegex,
        (String line) {
          final match = MarkdownPattern.strikethroughRegex.firstMatch(line)!;
          final content = match.group(1)!;
          return Strikethrough(
            key: key,
            text: line,
          )..renderText = content;
        }
      ),
      (
        MarkdownPattern.imageRegex,
        (String line) {
          final match = MarkdownPattern.imageRegex.firstMatch(line)!;
          final altText = match.group(1)!;
          return ImageNode(
            key: key,
            text: line,
          )..renderText = altText;
        }
      ),
      (
        MarkdownPattern.linkRegex,
        (String line) {
          final match = MarkdownPattern.linkRegex.firstMatch(line)!;
          final linkText = match.group(1)!;
          return Link(
            key: key,
            text: line,
          )..renderText = linkText;
        }
      ),
      (
        MarkdownPattern.highlightRegex,
        (String line) {
          final match = MarkdownPattern.highlightRegex.firstMatch(line)!;
          final content = match.group(1)!;
          return Highlight(
            key: key,
            text: line,
          )..renderText = content;
        }
      ),
      (
        MarkdownPattern.subscriptRegex,
        (String line) {
          return Subscript(
            key: key,
            text: line,
          )..renderText = line;
        }
      ),
      (
        MarkdownPattern.superscriptRegex,
        (String line) {
          return Superscript(
            key: key,
            text: line,
          )..renderText = line;
        }
      ),
      (
        MarkdownPattern.horizontalRuleRegex,
        (String line) {
          return HorizontalRule(
            key: key,
            text: line,
          )..renderText = '---';
        }
      ),
      (
        MarkdownPattern.inlineMathRegex,
        (String line) {
          return Math(
            key: key,
            text: line,
          )..renderText = line;
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
          )..renderText = '';
        }
      ),
      (
        MarkdownPattern.quoteRegex,
        (String line) {
          return Quote(
            key: key,
            text: line,
          )..renderText = line;
        }
      ),
      (
        MarkdownPattern.tableHeaderRegex,
        (String line) {
          return TableHeader(
            key: key,
            text: line,
          )..renderText = line;
        }
      ),
      (
        MarkdownPattern.tableLineRegex,
        (String line) {
          return TableLine(
            key: key,
            text: line,
          )..renderText = line;
        }
      ),
    ];

    for (final (pattern, builder) in patterns) {
      if (pattern.hasMatch(line)) {
        return builder(line);
      }
    }
    return TextNode(
      key: key,
      text: line,
    )..renderText = line;
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
