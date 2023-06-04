import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_db_demo/component/component.dart';
import 'package:hive_db_demo/model/model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteManager>(
      builder: (context, noteManager, child) {
        final allNote = noteManager.allNote;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Hive DB Demo'),
            actions: [
              if (allNote.isNotEmpty)
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: SearchWidget());
                  },
                  icon: const Icon(Icons.search),
                ),

              if (allNote.isNotEmpty)
                TextButton.icon(
                  onPressed: () {
                    Provider.of<NoteManager>(context, listen: false)
                        .deleteAll();
                  },
                  icon: const Icon(Icons.delete_forever),
                  label: const Text('Delete All'),
                ),
            ],
          ),
          body: _buildBody(context, allNote),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.goNamed('noteScreen');
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, List<Note> allNote) {
    if (allNote.isEmpty) {
      return const Center(
        child: Text('No Note'),
      );
    }
    return ListView.builder(
      itemCount: allNote.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final note = allNote.reversed.toList()[index];
        return InkWell(
          onTap: () {
            context.goNamed('noteScreen', extra: note);
          },
          child: ListTile(
            title: Text(note.noteTitle),
            subtitle: Text(note.noteBody),
          ),
        );
      },
    );
  }
}
