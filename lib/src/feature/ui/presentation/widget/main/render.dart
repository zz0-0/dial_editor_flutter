import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' as md;

class Render {
  Render();

  Text render(md.Node node) {
    if (node is md.Element) {
      if (node.tag == 'h1') {
        return Text(
          node.textContent,
          style: const TextStyle(
            fontSize: 40,
            color: Colors.black,
          ),
        );
      } else if (node.tag == 'h2') {
        return Text(
          node.textContent,
          style: const TextStyle(
            fontSize: 36,
            color: Colors.black,
          ),
        );
      } else if (node.tag == 'h3') {
        return Text(
          node.textContent,
          style: const TextStyle(
            fontSize: 32,
            color: Colors.black,
          ),
        );
      } else if (node.tag == 'h4') {
        return Text(
          node.textContent,
          style: const TextStyle(
            fontSize: 28,
            color: Colors.black,
          ),
        );
      } else if (node.tag == 'h5') {
        return Text(
          node.textContent,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        );
      } else if (node.tag == 'h6') {
        return Text(
          node.textContent,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        );
      } else if (node.tag == 'p') {
        return Text(node.textContent);
      } else if (node.tag == 'blockquote') {
        return Text(node.textContent);
      } else if (node.tag == 'ul') {
        return Text(node.textContent);
      } else if (node.tag == 'code') {
        return Text(node.textContent);
      }
      // else if (node.tag == '') {
      //   Text(node.textContent);
      // } else if (node.tag == '') {
      //   Text(node.textContent);
      // } else if (node.tag == '') {
      //   Text(node.textContent);
      // } else if (node.tag == '') {
      //   Text(node.textContent);
      // } else if (node.tag == '') {
      //   Text(node.textContent);
      // } else if (node.tag == '') {
      //   Text(node.textContent);
      // } else if (node.tag == '') {
      //   Text(node.textContent);
      // } else if (node.tag == '') {
      //   Text(node.textContent);
      // } else if (node.tag == '') {
      //   Text(node.textContent);
      // } else if (node.tag == '') {
      //   Text(node.textContent);
      // }
      else {
        return Text(node.textContent);
      }
    }
    return const Text("");
  }

  List<Text> renderList(List<md.Node> nodes) {
    final List<Text> markdownWidgetList = [];

    for (final node in nodes) {
      markdownWidgetList.add(render(node));
    }

    return markdownWidgetList;
  }
}
