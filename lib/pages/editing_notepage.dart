import 'package:appleui_notesapp/models/note_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

// ignore: must_be_immutable
class EditingNotePage extends StatefulWidget {
  Note note;
  bool isNewNote;

  EditingNotePage({
    super.key,
    required this.note,
    required this.isNewNote,
  });

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }

  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
      );
    });
  }

  //addmnew note
  void addNewNote() {
    //get new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    //get text from editor
    String text = _controller.document.toPlainText();
    //add new note
    Provider.of<NoteData>(context, listen: false).addNewNote(
      Note(id: id, text: text),
    );
  }

  //update existing note
  void updateNote() {
    // get text from editor
    String text = _controller.document.toPlainText();
    //update note
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      // backgroundColor: CupertinoColors.systemGroupedBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios
                        // color: Colors.black,
                        ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 16.0),

            //toolbar
            Container(
              color: Colors.teal[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: QuillToolbar.basic(
                  axis: Axis.horizontal,
                  controller: _controller,
                  // showAlignmentButtons: false,
                  // showBackgroundColorButton: false,
                  // showCenterAlignment: false,
                  // showColorButton: false,
                  // showCodeBlock: false,
                  // showDirection: false,
                  // showFontFamily: false,
                  // showDividers: false,
                  // showIndent: false,
                  // showHeaderStyle: false,
                  // showLink: false,
                  // showSearchButton: false,
                  // showInlineCode: false,
                  // showQuote: false,
                  // showListBullets: false,
                  // showListCheck: false,
                  // showListNumbers: false,
                  // showClearFormat: false,
                  // showFontSize: false,
                  // showStrikeThrough: false,
                  // showUnderLineButton: false,
                  // showItalicButton: false,
                  // showBoldButton: false,
                  // showSubscript: false,
                  // showSuperscript: false,
                ),
              ),
            ),
            //editor
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: QuillEditor.basic(
                  controller: _controller,
                  readOnly: false,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.teal[200],
              child: TextButton(
                style: ButtonStyle(iconSize: MaterialStateProperty.all(50.0)),
                onPressed: () {
                  //if its a new note
                  if (widget.isNewNote && !_controller.document.isEmpty()) {
                    addNewNote();
                  }

                  // its an existing notte
                  else {
                    updateNote();
                  }
                  Navigator.pop(context);
                },
                child: const Icon(Icons.save),
              ),
            )
          ],
        ),
      ),
    );
  }
}
