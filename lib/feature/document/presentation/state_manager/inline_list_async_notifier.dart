import 'dart:async';

import 'package:dial_editor_flutter/feature/document/data/data_source/local/file_local_data_source.dart';
import 'package:dial_editor_flutter/feature/document/data/gateway_impl/document_gateway_impl.dart';
import 'package:dial_editor_flutter/feature/document/domain/gateway/gateway/document_gateway.dart';
import 'package:dial_editor_flutter/feature/document/domain/use_case/get_document_use_case.dart';
import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:dial_editor_flutter/share/provider/document/presentation/state_manager/inline_notifier_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class InlineListAsyncNotifier extends AsyncNotifier<List<Inline>> {
  InlineListAsyncNotifier();

  late DocumentGateway _documentGateway;

  @override
  Future<List<Inline>> build() async {
    _documentGateway = DocumentGatewayImpl(FileLocalDataSourceImpl(ref));
    final document = await GetDocumentUseCase(_documentGateway)();
    final inlines = document.inlines.toList();
    for (final inline in inlines) {
      ref.read(inlineProvider(inline.key).notifier).initialize(inline);
    }
    return inlines;
  }

  Future<void> removeInline(Inline inline) async {
    final inlines = inline.list;
    inlines!.remove(inline);
    state = [...inlines] as AsyncValue<List<Inline>>;
    // state = state.copyWith(list: inlines);
  }
}
