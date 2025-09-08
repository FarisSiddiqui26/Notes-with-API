import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/features/notes/view/add_edit_note_view.dart';
import 'package:notes/features/notes/widgets/note_card.dart';
import '../viewmodel/notes_viewmodel.dart';
// import 'add_edit_note_view.dart';
// import 'note_card.dart';

class NotesView extends ConsumerWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesViewModelProvider);

    // Initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notesViewModelProvider.notifier).loadNotes();
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: notes.isEmpty
          ? const Center(child: Text('No notes yet!'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteCard(note: note); // NoteCard is a custom widget
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddEditNoteView())),
        child: const Icon(Icons.add),
      ),
    );
  }
}