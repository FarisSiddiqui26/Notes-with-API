import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:faz_flutter_task/core/theme/app_theme.dart';
import 'package:notes/core/theme/app_theme.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeColor = ref.watch(themeColorProvider);
    final colors = [Colors.blue, Colors.green, Colors.purple, Colors.orange];

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Dark Theme'),
            trailing: Switch(
              value: themeMode == ThemeMode.dark,
              onChanged: (_) => ref.read(themeModeProvider.notifier).toggleTheme(),
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Seed Color', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colors.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () => ref.read(themeColorProvider.notifier).changeColor(colors[index]),
                    child: CircleAvatar(
                      backgroundColor: colors[index],
                      child: themeColor == colors[index]
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}