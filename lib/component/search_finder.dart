import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_db_demo/model/model.dart';
import 'package:provider/provider.dart';

class SearchFinder extends StatelessWidget {
  const SearchFinder({super.key, required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteManager>(
      builder: (context, noteManager, child) {
        final allNote = noteManager.allNote;
        final result = query.isEmpty
            ? []
            : allNote
                .where((element) =>
                    element.noteTitle.contains(query) ||
                    element.noteBody.contains(query))
                .toList();

        return result.isEmpty
            ? const Center(
                child: Text('No Result Found!'),
              )
            : ListView.builder(
                itemCount: result.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final note = result[index];
                  return ListTile(
                    title: Text(note.noteTitle),
                    subtitle: Text(note.noteBody),
                    onTap: () {
                      context.goNamed('noteScreen', extra: note);
                    },
                  );
                },
              );
      },
    );
  }
}
