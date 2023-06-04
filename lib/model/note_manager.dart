import 'package:flutter/material.dart';
import 'package:hive_db_demo/db/hive_db.dart';
import 'package:hive_db_demo/model/model.dart';

class NoteManager extends ChangeNotifier{
  final _dbObj = HiveDb.getInstance();
  List<Note> get allNote => List.unmodifiable(_allNotes());

  void addNote(Note note){
    // _dbObj.addNote(note);
    _dbObj.updateNote(note);
    notifyListeners();
  }

  void deleteNote(String noteId){
    _dbObj.deleteNote(noteId);
    notifyListeners();
  }

  void deleteAll(){
    _dbObj.clearAll();
    notifyListeners();
  }

  void updateNote(Note note){
    _dbObj.updateNote(note);
    notifyListeners();
  }

  List<Note> _allNotes(){
    return _dbObj.notes();
  }
}