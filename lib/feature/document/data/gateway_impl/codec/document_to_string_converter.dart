import 'dart:convert';

import 'package:dial_editor_flutter/feature/document/domain/model/document.dart';

class DocumentToStringConverter extends Converter<Document, String> {
  @override
  String convert(Document input) {
    return input.toString();
  }
}
