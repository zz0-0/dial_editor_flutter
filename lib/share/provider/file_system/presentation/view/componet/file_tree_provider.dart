import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final fileProvider = StateProvider.family<File?, String>((ref, id) => null);
final fileIdProvider = StateProvider<String?>((ref) => null);
