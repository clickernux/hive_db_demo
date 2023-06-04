import 'package:hive_flutter/adapters.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  Note({
    required this.noteId,
    this.noteTitle = '',
    this.noteBody = '',
  });

  @HiveField(0)
  final String noteId;

  @HiveField(1)
  final String noteTitle;

  @HiveField(2)
  final String noteBody;

  Note copy({String? title, String? body}) {
    return Note(
      noteId: noteId,
      noteTitle: title ?? noteTitle,
      noteBody: body ?? noteBody,
    );
  }
}
