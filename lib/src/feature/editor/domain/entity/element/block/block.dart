import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

abstract class Block extends Node {
  List<Node>? children;
  GlobalKey blockKey;

  Block({
    required super.context,
    required super.rawText,
    this.children,
    super.style,
    super.text,
    super.parentKey,
    required this.blockKey,
  });
}
