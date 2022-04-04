import 'package:flutter/material.dart';
import 'package:notes_app/model/Note.dart';
import 'package:notes_app/screen/add_note_screen.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.pushNamed(context, AddNote.ROUTE_ID, arguments: note);
      },
      child: Hero(
        tag: note.id,
        child: Card(
          color: Color(note.color),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  note.title != null ? note.title : "",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  getNoteText(),
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getNoteText() {
    if (note.note != null) {
      if (note.note.length > 50) {
        return note.note.substring(0, 200) + "\u22EF";
      } else {
        return note.note;
      }
    } else {
      return "";
    }
  }
}
