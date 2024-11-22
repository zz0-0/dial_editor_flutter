import 'package:dial_editor_flutter/feature/document/domain/model/element/inline.dart';
import 'package:flutter/material.dart';

base class TableLine extends Inline {
  TableLine({required super.key, required super.text});

  @override
  Inline copyWith({
    TextStyle? textStyle,
    double? lineHeight,
    bool? isEditing,
    bool? isExpanded,
    bool? isBlockStart,
    int? level,
    int? baseOffset,
    int? extentOffset,
    String? text,
  }) {
    throw UnimplementedError();
  }
}
