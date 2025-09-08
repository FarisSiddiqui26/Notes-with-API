import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/features/notes/view/notes_view.dart';
import 'package:notes/features/posts/view/posts_view.dart';
import 'package:notes/features/settings/view/settings_view.dart';
//import 'package:faz_flutter_task/features/notes/view/notes_view.dart';
//import 'package:faz_flutter_task/features/posts/view/posts_view.dart';
//import 'package:faz_flutter_task/features/settings/view/settings_view.dart';

final navigationIndexProvider = StateProvider<int>((ref) => 0);

class HomeView extends ConsumerWidget {
  HomeView({super.key});

  final List<Widget> _screens = [
    NotesView(),
    PostsView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);

    return Scaffold(
      body: _screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(navigationIndexProvider.notifier).state = index;
        },
      ),
    );
  }
}