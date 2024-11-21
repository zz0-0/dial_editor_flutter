import 'dart:convert';

import 'package:dial_editor_flutter/feature/document/data/gateway_impl/codec/document_to_string_converter.dart';
import 'package:dial_editor_flutter/feature/document/data/gateway_impl/codec/string_to_document_converter.dart';
import 'package:dial_editor_flutter/feature/document/domain/model/document.dart';

class DocumentCodec extends Codec<String, Document> {
  DocumentCodec();

  @override
  Converter<Document, String> get decoder => DocumentToStringConverter();
  @override
  Converter<String, Document> get encoder => StringToDocumentConverter();
}
