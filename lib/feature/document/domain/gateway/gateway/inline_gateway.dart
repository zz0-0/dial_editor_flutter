import 'package:dial_editor_flutter/share/markdown_element.dart';

abstract interface class InlineGateway {
  Document convertToDocument(List<String> lines);
  Inline convert(String line);
}
