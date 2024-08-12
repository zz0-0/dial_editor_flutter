import 'package:flutter/material.dart';

abstract class Node {
  GlobalKey<EditableTextState> key = GlobalKey<EditableTextState>();
  GlobalKey<EditableTextState>? parentKey;
  List<GlobalKey> ancestorKeys = [];
}
