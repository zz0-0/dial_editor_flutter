import 'package:dial_editor_flutter/feature/document/presentation/state_manager/render_util_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final renderUtilProvider = Provider<RenderUtil>((ref) {
//   return RenderUtil();
// });

final renderUtilProvider = NotifierProvider<RenderUtilNotifier, void>(
  RenderUtilNotifier.new,
);
