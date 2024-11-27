import 'package:dial_editor_flutter/feature/document/domain/gateway/gateway/inline_gateway.dart';
import 'package:dial_editor_flutter/feature/document/domain/model/element/inline.dart';

class ConvertLineUseCase {
  ConvertLineUseCase(this._inlineGateway);

  final InlineGateway _inlineGateway;
  
  Inline call(String line) {
    return _inlineGateway.convert(line);
  }
}
