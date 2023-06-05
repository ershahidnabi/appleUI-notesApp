import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../models/note_data.dart';
import 'editing_notepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  //create a new note
  void createNewNote() {
    //create new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    //create a blank note
    Note newNote = Note(
      id: id,
      text: '',
    );

    //goto edit the note
    goToNotePage(newNote, true);
  }

  //go to note editing page
  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingNotePage(
          note: note,
          isNewNote: isNewNote,
        ),
      ),
    );
  }

  //delete note
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        // backgroundColor: CupertinoColors.systemGroupedBackground,
        // backgroundColor: Colors.teal[200],

        //new note button
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          elevation: 0,
          backgroundColor: Colors.teal[100],
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25.0, top: 75.0, bottom: 10.0),
                child: Center(
                  child: Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      textBaseline: TextBaseline.alphabetic,
                    ),
                  ),
                ),
              ),

              // list of notes
              value.getAllNotes().isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Center(
                        child: Text(
                          "Nothing here...",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    )
                  : CupertinoListSection.insetGrouped(
                      // backgroundColor: const Color.fromARGB(255, 77, 182, 172),
                      // margin: const EdgeInsets.all(10.0),
                      children: List.generate(
                        value.getAllNotes().length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: CupertinoListTile(
                            backgroundColor: Colors.teal[100],
                            title: Text(value.getAllNotes()[index].text),
                            onTap: () =>
                                goToNotePage(value.getAllNotes()[index], false),
                            trailing: IconButton(
                                onPressed: () =>
                                    deleteNote(value.getAllNotes()[index]),
                                icon: const Icon(Icons.delete)),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
