import 'package:appleui_notesapp/models/note.dart';
import 'package:hive/hive.dart';

class HiveDataBase {
  //rfrence our hive box
  final _myBox = Hive.box('note_database');

  //load notes
  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];

    // if there exist notes, return that, oterwise rturn empty list
    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedNotes = _myBox.get("ALL_NOTES");
      for (int i = 0; i < savedNotes.length; i++) {
        //create individual note
        Note individuialNote =
            Note(id: savedNotes[i][0], text: savedNotes[i][0]);
        //add to list
        savedNotesFormatted.add(individuialNote);
      }
    } else {
      //default first note
      savedNotesFormatted.add(
        Note(id: 0, text: 'My First Note'),
      );
    }
    return savedNotesFormatted;
  }

  //save notes
  void savedNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [
      /*
      [
        [0, "First Note"],
        [1, "second note"],
        ..
      ]
      */
    ];
    // each note has an id and text
    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }

    //then store into hive
    _myBox.put("ALL_NOTES", allNotesFormatted);
  }
}
