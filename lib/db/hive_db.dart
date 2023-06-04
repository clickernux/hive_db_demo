import 'package:hive_db_demo/model/model.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDb{
  static const dbName = 'NoteDb';
  HiveDb._internal();
  static HiveDb getInstance() => HiveDb._internal();

  // void addNote(Note note) async{
  //   final db = Hive.lazyBox(dbName);
  //   await db.add(note);
  // }

  void updateNote(Note note) async{ 
    final db = Hive.box(dbName);
    await db.put(note.noteId, note);
  }

  void deleteNote(String noteId) async{
    final db = Hive.box(dbName);
    await db.delete(noteId);
  }

  Note getNote(String noteId) {
    final db = Hive.box(dbName);
    return db.get(noteId);
  }

  void clearAll() async{
    final db = Hive.box(dbName);
    final totalCleared = await db.clear();
    print('Total Deleted: $totalCleared');
  }

  List<Note> notes() {
    final db = Hive.box(dbName);
    return db.values.toList().cast<Note>();
  }
  
}