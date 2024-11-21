import 'package:dial_editor_flutter/feature/document/domain/gateway/gateway/document_gateway.dart';

import 'package:dial_editor_flutter/feature/document/domain/model/document.dart';

class GetDocumentUseCase {
  GetDocumentUseCase(this._documentGateway);
  final DocumentGateway _documentGateway;

  Future<Document> call() async {
    return _documentGateway.encode();
  }
}
