import 'dart:io';

import 'package:dial_editor/src/feature/editor/presentation/widget/markdown_render.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown/markdown.dart' as md;

class EditPart extends ConsumerStatefulWidget {
  final File file;
  const EditPart({super.key, required this.file});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPartState();
}

class _EditPartState extends ConsumerState<EditPart> {
  List<Text> markdownWidgetList = [];
  List<md.Node> nodes = [];
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  TextStyle currentTextStyle = const TextStyle();
  int editingLineIndex = -1;

  @override
  void initState() {
    super.initState();
    nodes = md.Document().parse(widget.file.readAsStringSync());
    markdownWidgetList = MarkdownRender().renderList(nodes);
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: markdownWidgetList.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            SizedBox(
              width: 30,
              child: Text("${index + 1}"),
            ),
            Expanded(
              child: index == editingLineIndex
                  ? EditableText(
                      controller: controller,
                      focusNode: focusNode,
                      style: currentTextStyle,
                      cursorColor: Colors.blue,
                      backgroundCursorColor: Colors.white,
                      onEditingComplete: () {
                        setState(() {
                          nodes[editingLineIndex] = md.Text(controller.text);
                          markdownWidgetList[editingLineIndex] =
                              MarkdownRender().render(nodes[editingLineIndex]);
                          editingLineIndex = -1;
                          controller.clear();
                          currentTextStyle = const TextStyle();
                        });
                      },
                    )
                  : GestureDetector(
                      onTapUp: (details) {
                        setState(() {
                          editingLineIndex = index;

                          controller.text = nodes[index].textContent;
                          controller.selection = TextSelection.collapsed(
                            offset: controller.text.length,
                          );
                          currentTextStyle = markdownWidgetList[index].style ??
                              const TextStyle();
                        });
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          focusNode.requestFocus();
                        });
                      },
                      child: markdownWidgetList[index],
                    ),
            ),
          ],
        );
      },
    );
  }
}
