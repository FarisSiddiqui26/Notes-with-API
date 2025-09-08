import 'package:flutter/material.dart';
import 'package:notes/features/notes/view/add_edit_note_view.dart';
import '../../notes/model/note.dart';
//import '../../notes/view/add_edit_note_view.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({required this.note, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(note.title, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(note.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        onTap: () {
          // Navigate to a view to edit the note
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditNoteView(note: note)));
        },
      ),
    );
  }
}