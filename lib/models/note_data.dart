import 'package:appleui_notesapp/models/note.dart';
import 'package:flutter/material.dart';

import '../data/hive_database.dart';

class NoteData extends ChangeNotifier {
  //hive database
  final db = HiveDataBase();

  //Overall list of notes
  List<Note> allNotes = [];

  //initialize
  void initializeNotes() {
    allNotes = db.loadNotes();
  }

  //get notes
  List<Note> getAllNotes() {
    return allNotes;
  }

  //add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  //update note
  void updateNote(Note note, String text) {
    //go thru list of all notes
    for (int i = 0; i < allNotes.length; i++) {
      //find the relevent note
      if (allNotes[i].id == note.id) {
        //replace text
        allNotes[i].text = text;
        notifyListeners();
      }
    }
  }

  //delete note
  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
