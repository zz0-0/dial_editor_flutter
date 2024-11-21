import 'package:dial_editor_flutter/feature/document/domain/model/document.dart';

abstract interface class DocumentGateway {
  Future<String> decode(Document document);
  Future<Document> encode();
}
