import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';
import 'package:flutter/material.dart';

class NodeRepositoryImpl implements NodeRepository {
  @override
  (List<GlobalKey>, Map<GlobalKey, Node>) convertDocument(List<String> lines) {
    final List<GlobalKey> nodeKeyList = [];
    final Map<GlobalKey, Node> nodeMap = {};
    OrderedListBlock? currentOrderedListBlock;
    TaskListBlock? currentTaskListBlock;
    UnorderedListBlock? currentUnorderedListBlock;
    CodeBlock? currentCodeBlock;
    HeadingBlock? currentHeadingBlock;
    MathBlock? currentMathBlock;
    QuoteBlock? currentQuoteBlock;
    bool isCodeBlock = false;

    for (final line in lines) {
      final Node node;
      if (isCodeBlock) {
        node = CodeLine(rawText: line, key: GlobalKey());
      } else {
        node = convert(line);
      }
      if (node is Heading) {
        if (currentHeadingBlock != null) {
          if (node.level >= currentHeadingBlock.level) {
            // children.add(currentHeadingBlock);
            nodeKeyList.add(currentHeadingBlock.key);
            nodeMap[currentHeadingBlock.key] = currentHeadingBlock;
            currentHeadingBlock = HeadingBlock(
              level: node.level,
              key: GlobalKey(),
            );
            currentHeadingBlock.key = GlobalKey();
            node.isBlockStart = true;
            node.parentKey = currentHeadingBlock.key;
            currentHeadingBlock.children.add(node);
          } else {
            node.parentKey = currentHeadingBlock.key;
            currentHeadingBlock.children.add(node);
          }
        } else {
          currentHeadingBlock = HeadingBlock(
            level: node.level,
            key: GlobalKey(),
          );
          currentHeadingBlock.key = GlobalKey();
          node.isBlockStart = true;
          node.parentKey = currentHeadingBlock.key;
          currentHeadingBlock.children.add(node);
        }
      } else if (currentHeadingBlock != null) {
        if (node is OrderedListNode) {
          if (currentOrderedListBlock != null) {
            node.parentKey = currentOrderedListBlock.key;
            currentOrderedListBlock.children.add(node);
          } else {
            currentOrderedListBlock = OrderedListBlock(
              key: GlobalKey(),
            );
            currentOrderedListBlock.key = GlobalKey();
            node.isBlockStart = true;
            node.parentKey = currentOrderedListBlock.key;
            currentOrderedListBlock.children.add(node);
            currentHeadingBlock.children.add(currentOrderedListBlock);
          }
        } else if (node is TaskListNode) {
          if (currentTaskListBlock != null) {
            node.parentKey = currentTaskListBlock.key;
            currentTaskListBlock.children.add(node);
          } else {
            currentTaskListBlock = TaskListBlock(
              key: GlobalKey(),
            );
            currentTaskListBlock.key = GlobalKey();
            node.isBlockStart = true;
            node.parentKey = currentTaskListBlock.key;
            currentTaskListBlock.children.add(node);
            currentHeadingBlock.children.add(currentTaskListBlock);
          }
        } else if (node is UnorderedListNode) {
          if (currentUnorderedListBlock != null) {
            node.parentKey = currentUnorderedListBlock.key;
            currentUnorderedListBlock.children.add(node);
          } else {
            currentUnorderedListBlock = UnorderedListBlock(
              key: GlobalKey(),
            );
            currentUnorderedListBlock.key = GlobalKey();
            node.isBlockStart = true;
            node.parentKey = currentUnorderedListBlock.key;
            currentUnorderedListBlock.children.add(node);
            currentHeadingBlock.children.add(currentUnorderedListBlock);
          }
        } else if (node is Math) {
          if (currentMathBlock != null) {
            node.parentKey = currentMathBlock.key;
            currentMathBlock.children.add(node);
          } else {
            currentMathBlock = MathBlock(
              key: GlobalKey(),
            );
            currentMathBlock.key = GlobalKey();
            node.isBlockStart = true;
            node.parentKey = currentMathBlock.key;
            currentMathBlock.children.add(node);
            currentHeadingBlock.children.add(currentMathBlock);
          }
        } else if (node is Quote) {
          if (currentQuoteBlock != null) {
            node.parentKey = currentQuoteBlock.key;
            currentQuoteBlock.children.add(node);
          } else {
            currentQuoteBlock = QuoteBlock(
              key: GlobalKey(),
            );
            currentQuoteBlock.key = GlobalKey();
            node.isBlockStart = true;
            node.parentKey = currentQuoteBlock.key;
            currentQuoteBlock.children.add(node);
            currentHeadingBlock.children.add(currentQuoteBlock);
          }
        } else if (node is CodeBlockMarker) {
          if (isCodeBlock == false) {
            isCodeBlock = true;
            final match = codeBlockRegex.firstMatch(line);
            final String language =
                match!.groupCount >= 1 && match.group(1) != null
                    ? match.group(1)!
                    : 'c';
            currentCodeBlock = CodeBlock(
              key: GlobalKey(),
            );
            currentCodeBlock.key = GlobalKey();
            currentCodeBlock.language = language;
            node.language = language;
            node.isBlockStart = true;
            node.parentKey = currentCodeBlock.key;
            currentCodeBlock.children.add(node);
          } else {
            isCodeBlock = false;
            currentHeadingBlock.children.add(node);
            nodeKeyList.add(currentCodeBlock!.key);
            nodeMap[currentCodeBlock.key] = currentCodeBlock;
            currentCodeBlock = null;
          }
        } else if (node is CodeLine) {
          if (currentCodeBlock != null) {
            node.parentKey = currentCodeBlock.key;
            currentCodeBlock.children.add(node);
          }
        } else if (node is CodeBlockMarker && currentCodeBlock != null) {
          nodeKeyList.add(currentCodeBlock.key);
          nodeMap[currentCodeBlock.key] = currentCodeBlock;
          currentCodeBlock = null;
        } else {
          (node as Inline).parentKey = currentHeadingBlock.key;
          currentHeadingBlock.children.add(node);
        }
      } else {
        nodeKeyList.add(node.key);
        nodeMap[node.key] = node;
      }
    }
    if (currentHeadingBlock != null) {
      nodeKeyList.add(currentHeadingBlock.key);
      nodeMap[currentHeadingBlock.key] = currentHeadingBlock;
    }
    return (nodeKeyList, nodeMap);
  }

  @override
  Inline convert(String input) {
    if (codeBlockRegex.hasMatch(input)) {
      return CodeBlockMarker(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (taskListRegex.hasMatch(input)) {
      return TaskListNode(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (orderListRegex.hasMatch(input)) {
      return OrderedListNode(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (unorderedListRegex.hasMatch(input)) {
      return UnorderedListNode(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (headingRegex.hasMatch(input)) {
      return Heading(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (inlineMathRegex.hasMatch(input)) {
      return Math(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (quoteRegex.hasMatch(input)) {
      return Quote(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (boldItalicRegex.hasMatch(input)) {
      return BoldItalic(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (boldRegex.hasMatch(input)) {
      return Bold(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (italicRegex.hasMatch(input)) {
      return Italic(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (highlightRegex.hasMatch(input)) {
      return Highlight(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (strikethroughRegex.hasMatch(input)) {
      return Strikethrough(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (imageRegex.hasMatch(input) || imageUrlRegex.hasMatch(input)) {
      return ImageNode(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (linkRegex.hasMatch(input) || urlRegex.hasMatch(input)) {
      return Link(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (subscriptRegex.hasMatch(input)) {
      return Subscript(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (superscriptRegex.hasMatch(input)) {
      return Superscript(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (horizontalRuleRegex.hasMatch(input)) {
      return HorizontalRule(
        rawText: input,
        key: GlobalKey(),
      );
    } else if (emojiRegex.hasMatch(input)) {
      return Emoji(
        rawText: input,
        key: GlobalKey(),
      );
    } else {
      return TextNode(
        rawText: input,
        key: GlobalKey(),
      );
    }
  }
}
