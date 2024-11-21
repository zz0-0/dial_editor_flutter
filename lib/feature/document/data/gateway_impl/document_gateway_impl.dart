import 'package:dial_editor_flutter/feature/document/data/data_source/local/file_local_data_source.dart';
import 'package:dial_editor_flutter/feature/document/data/gateway_impl/codec/document_codec.dart';
import 'package:dial_editor_flutter/feature/document/domain/gateway/gateway/document_gateway.dart';
import 'package:dial_editor_flutter/feature/document/domain/model/document.dart';

class DocumentGatewayImpl implements DocumentGateway {
  DocumentGatewayImpl(this._fileLocalDataSource);

  final FileLocalDataSource _fileLocalDataSource;

  @override
  Future<String> decode(Document document) async {
    return DocumentCodec().decode(document);
  }

  @override
  Future<Document> encode() async {
    final file = await _fileLocalDataSource.readFile();
    final content = file.readAsStringSync();
    return DocumentCodec().encode(content);
  }
}
