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
          final level = match.group(1)!.length;
          return Heading(text: line, key: key)
            ..level = level
            ..isBlockStart = true;
        }
      ),
      (
        MarkdownPattern.boldItalicRegex,
        (String line) {
          return BoldItalic(text: line, key: key);
        }
      ),
      (
        MarkdownPattern.boldRegex,
        (String line) {
          return Bold(text: line, key: key);
        }
      ),
      (
        MarkdownPattern.italicRegex,
        (String line) {
          return Italic(text: line, key: key);
        }
      ),
      (
        MarkdownPattern.unorderedListRegex,
        (String line) {
          return UnorderedListNode(text: line, key: key);
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
          return TaskListNode(text: line, key: key);
        }
      ),
      (
        MarkdownPattern.strikethroughRegex,
        (String line) {
          return Strikethrough(text: line, key: key);
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
          return Link(text: line, key: key);
        }
      ),
      (
        MarkdownPattern.highlightRegex,
        (String line) {
          return Highlight(text: line, key: key);
        }
      ),
      (
        MarkdownPattern.subscriptRegex,
        (String line) {
          return Subscript(text: line, key: key);
        }
      ),
      (
        MarkdownPattern.superscriptRegex,
        (String line) {
          return Superscript(text: line, key: key);
        }
      ),
      (
        MarkdownPattern.horizontalRuleRegex,
        (String line) {
          return HorizontalRule(text: line, key: key);
        }
      ),
      (
        MarkdownPattern.inlineMathRegex,
        (String line) {
          return Math(text: line, key: key);
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
    ];

    for (final (pattern, builder) in patterns) {
      if (pattern.hasMatch(line)) {
        return builder(line);
      }
    }
    return TextNode(text: line, key: key);
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
    } else {
      if (inline is! Heading) {
        currentCodeBlock = null;
        currentMathBlock = null;
        currentOrderedListBlock = null;
        currentTaskListBlock = null;
        currentUnorderedListBlock = null;
        currentQuoteBlock = null;
      }
    }
  }
}
