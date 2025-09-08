import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/note.dart';
import '../viewmodel/notes_viewmodel.dart';

class AddEditNoteView extends ConsumerStatefulWidget {
  final Note? note;

  const AddEditNoteView({this.note, super.key});

  @override
  ConsumerState<AddEditNoteView> createState() => _AddEditNoteViewState();
}

class _AddEditNoteViewState extends ConsumerState<AddEditNoteView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _descriptionController = TextEditingController(text: widget.note?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();

      if (widget.note == null) {
        // Add new note
        ref.read(notesViewModelProvider.notifier).addNote(title, description);
      } else {
        // Edit existing note
        final updatedNote = Note(
          id: widget.note!.id,
          title: title,
          description: description,
        );
        ref.read(notesViewModelProvider.notifier).updateNote(updatedNote);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref.read(notesViewModelProvider.notifier).deleteNote(widget.note!, context);
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
      body: Padding(
        padding: const  EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
              ),
               const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
               SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveNote,
                child: Text(widget.note == null ? 'Add Note' : 'Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}