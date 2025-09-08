import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/core/theme/app_theme.dart';
import 'package:notes/features/home/home_view.dart';
import 'package:notes/features/notes/view/notes_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError());

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeColor = ref.watch(themeColorProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(themeColor),
      darkTheme: darkTheme(themeColor),
      themeMode: themeMode,
      home: HomeView(),
    );
  }
}
