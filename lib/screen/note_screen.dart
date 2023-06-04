import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_db_demo/model/model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key, this.note});
  final Note? note;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool _isNewNote = true;
  final _titleController = TextEditingController();
  final _bodyTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isNewNote = widget.note == null ? true : false;
    final note = widget.note;
    if (note != null) {
      _titleController.text = note.noteTitle;
      _bodyTextController.text = note.noteBody;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final originalNote = widget.note;
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNewNote ? 'New Note' : widget.note?.noteTitle ?? ''),
        actions: [
          IconButton(
            onPressed: () {
              final note = Note(
                noteId: widget.note?.noteId ?? const Uuid().v1(),
                noteTitle: _titleController.text,
                noteBody: _bodyTextController.text,
              );

              if (_isNewNote) {
                Provider.of<NoteManager>(context, listen: false).addNote(note);
              } else {
                Provider.of<NoteManager>(context, listen: false)
                    .updateNote(note);
              }
              context.pop();
            },
            icon: const Icon(Icons.done),
          ),
          if (!_isNewNote)
            IconButton(
              onPressed: () {
                Provider.of<NoteManager>(context, listen: false)
                    .deleteNote(originalNote!.noteId);
                    print('Deleted Note: ${originalNote.noteId}');
                context.pop();
              },
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverToBoxAdapter(
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              style: textTheme.headlineMedium,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverFillRemaining(
            hasScrollBody: false,
            child: TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: _bodyTextController,
              decoration: const InputDecoration(
                hintText: 'Content',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
