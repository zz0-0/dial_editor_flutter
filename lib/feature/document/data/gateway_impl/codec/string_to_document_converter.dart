import 'dart:convert';

import 'package:dial_editor_flutter/feature/document/data/gateway_impl/inline_gateway_impl.dart';
import 'package:dial_editor_flutter/feature/document/domain/model/document.dart';

class StringToDocumentConverter extends Converter<String, Document> {
  @override
  Document convert(String input) {
    final inlineGateway = InlineGatewayImpl();
    final lines = input.split('\n');
    return inlineGateway.convertToDocument(lines);
  }
}
