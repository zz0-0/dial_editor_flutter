import 'package:dial_editor_flutter/feature/document/domain/model/element/inline.dart';
import 'package:dial_editor_flutter/feature/document/presentation/state_manager/inline_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inlineProvider =
    NotifierProvider.family<InlineNotifier, Inline, GlobalKey>(
  InlineNotifier.new,
);
final toggleLevelProvider = StateProvider<int>((ref) => 0);
