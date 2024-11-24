import 'package:dial_editor_flutter/feature/document/domain/model/element/inline.dart';
import 'package:dial_editor_flutter/feature/document/domain/model/element/inline/table/table_line.dart';
import 'package:flutter/material.dart';

base class TableHeader extends Inline {
  TableHeader({
    required super.key,
    required super.text,
    required super.renderText,
  });

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
    String? renderText,
  }) {
    throw UnimplementedError();
  }

  @override
  Inline createNewLine() {
    return TableLine(key: key, text: '', renderText: '');
  }
}
