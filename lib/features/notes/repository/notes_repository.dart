import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import '../model/note.dart';

class NotesRepository {
  final SharedPreferences _prefs;
  static const _notesKey = 'notes';

  NotesRepository(this._prefs);

  Future<List<Note>> getNotes() async {
    final notesString = _prefs.getStringList(_notesKey) ?? [];
    return notesString.map((note) => Note.fromJson(jsonDecode(note))).toList();
  }

  Future<void> saveNotes(List<Note> notes) async {
    final notesString = notes.map((note) => jsonEncode(note.toJson())).toList();
    await _prefs.setStringList(_notesKey, notesString);
  }
}

final notesRepositoryProvider = Provider<NotesRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return NotesRepository(prefs);
});