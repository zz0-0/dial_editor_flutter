import 'package:dial_editor_flutter/feature/document/domain/model/element/block.dart';

base class CodeBlock extends Block {
  CodeBlock({required super.key, required super.level, this.language = 'c'});
  String language;
}
