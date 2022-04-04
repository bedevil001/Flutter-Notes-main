import 'package:flutter/foundation.dart';
import 'package:notes_app/model/db_helper.dart';
import 'package:uuid/uuid.dart';

import 'Note.dart';

class NoteProvider with ChangeNotifier {
  DatabaseHelper helper = DatabaseHelper.instance;

  void insertNote(Note note) {
    if (isNotEmptyNote(note)) {
      note.id = Uuid().v4();
      note.time = DateTime.now().millisecondsSinceEpoch;
      helper.insert(note);
      notifyListeners();
    }
  }

  void updateNote(Note note) async {
    if (isNotEmptyNote(note)) {
      if (await hasChanged(note)) {
        note.time = DateTime.now().millisecondsSinceEpoch;
        helper.update(note);
        notifyListeners();
        print("add new");
      }
    }
  }

  Future<bool> hasChanged(Note note) async {
    Note old = Note.fromMap(await helper.getNote(note.id));
    return old != note;
  }

  Future<List<Note>> getNotes(String query) async {
    if (query != null && query.isNotEmpty) {
      return getNotesByQuery(query);
    } else {
      return getAllNotes();
    }
  }

  Future<List<Note>> getAllNotes() async {
    final List<Map<String, dynamic>> maps = await helper.getAll();
    return List.generate(maps.length, (index) => Note.fromMap(maps[index]));
  }

  Future<List<Note>> getNotesByQuery(String query) async {
    final List<Map<String, dynamic>> maps = await helper.getByQuery(query);
    return List.generate(maps.length, (index) => Note.fromMap(maps[index]));
  }

  bool isNotEmptyNote(Note note) {
    return ((note.title != null && note.title.isNotEmpty) ||
        (note.note != null && note.note.isNotEmpty));
  }

  void deleteNote(Note note) {
    print("deleting $note");
    if (note != null && note.id != null) {
      helper.delete(note.id);
      print("deleted");
      notifyListeners();
    }
  }
}
