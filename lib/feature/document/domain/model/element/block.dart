import 'package:flutter/material.dart';

abstract base class Block {
  Block({required this.key, required this.level});

  GlobalKey key;
  int level;
  bool isExpanded = true;
}
