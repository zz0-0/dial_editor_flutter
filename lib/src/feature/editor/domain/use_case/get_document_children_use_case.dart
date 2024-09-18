import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

class GetDocumentChildrenUseCase {
  final DocumentRepository repository;

  GetDocumentChildrenUseCase(this.repository);

  Future<List<Node>> call() async {
    final document = await repository.encode();
    return document.getNodesInOrder();
  }
}
