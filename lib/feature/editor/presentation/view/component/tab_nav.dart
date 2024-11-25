import 'dart:io';

import 'package:dial_editor_flutter/share/provider/editor/presentation/state_manager/opened_files_notifier_provider.dart';
import 'package:dial_editor_flutter/share/provider/file_system/presentation/view/componet/file_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabNav extends ConsumerStatefulWidget {
  const TabNav({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabNavState();
}

class _TabNavState extends ConsumerState<TabNav> with TickerProviderStateMixin {
  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    final openedFiles = ref.watch(openedFilesProvider);
    final id = ref.watch(fileIdProvider);
    final tabs = openedFiles.values
        .map(
          (path) => Row(
            children: [
              Tab(text: path.split(Platform.pathSeparator).last),
              IconButton(
                splashRadius: 20,
                icon: const Icon(Icons.close),
                onPressed: () {
                  ref.read(openedFilesProvider.notifier).removeFile(path);
                },
              ),
            ],
          ),
        )
        .toList();
    tabController = TabController(length: openedFiles.length, vsync: this);

    // switch tab when tap different file on file tree
    if (id != null) {
      final file = ref.watch(fileProvider(id));
      if (file != null) {
        final index = openedFiles.values.toList().indexOf(file.path);
        if (index != -1) {
          tabController!.index = index;
          tabController!.animateTo(index);
        }
      } else {
        if (openedFiles.isNotEmpty) {
          tabController!.index = openedFiles.length - 1;
          tabController!.animateTo(openedFiles.length - 1);
        }
      }
    } else {}

    return TabBar(
      controller: tabController,
      tabs: tabs,
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      onTap: (index) {
        tabController!.index = index;
        tabController!.animateTo(index);
        final id = openedFiles.keys.toList()[index];
        ref.read(fileIdProvider.notifier).state = id;
        ref.read(fileProvider(id).notifier).state =
            File(openedFiles.values.toList()[index]);
      },
    );
  }
}
