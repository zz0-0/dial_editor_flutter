import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fileProvider = StateProvider.family<File?, GlobalKey>((ref, key) => null);
final fileKeyProvider = StateProvider<GlobalKey?>((ref) => null);
