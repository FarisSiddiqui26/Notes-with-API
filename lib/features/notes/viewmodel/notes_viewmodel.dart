import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/note.dart';
import '../repository/notes_repository.dart';
import 'package:uuid/uuid.dart';

final notesViewModelProvider = StateNotifierProvider<NotesViewModel, List<Note>>((ref) {
  final repository = ref.watch(notesRepositoryProvider);
  return NotesViewModel(repository);
});

class NotesViewModel extends StateNotifier<List<Note>> {
  final NotesRepository _repository;
  final uuid = const Uuid();

  NotesViewModel(this._repository) : super([]);

  Future<void> loadNotes() async {
    state = await _repository.getNotes();
  }

  Future<void> addNote(String title, String description) async {
    final newNote = Note(id: uuid.v4(), title: title, description: description);
    state = [...state, newNote];
    await _repository.saveNotes(state);
  }

  Future<void> updateNote(Note updatedNote) async {
    state = [
      for (final note in state)
        if (note.id == updatedNote.id) updatedNote else note,
    ];
    await _repository.saveNotes(state);
  }

  Future<void> deleteNote(Note note, BuildContext context) async {
    final originalState = state;
    state = state.where((n) => n.id != note.id).toList();
    await _repository.saveNotes(state);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Note deleted.'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            state = originalState;
            _repository.saveNotes(state);
          },
        ),
      ),
    );
  }
}