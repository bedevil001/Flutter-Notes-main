import 'package:flutter/material.dart';
import 'package:notes_app/model/Note.dart';
import 'package:notes_app/model/note_color_state.dart';
import 'package:notes_app/model/note_provider.dart';
import 'package:notes_app/screen/notes_screen.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'color_list_view.dart';

class NotePopupMenu extends StatelessWidget {
  final Note note;

  const NotePopupMenu({Key key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteProvider provider = context.read<NoteProvider>();
    return Consumer<NoteColor>(
      builder: (context, value, child) {
        return Container(
          color: value.color,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.delete_outline_outlined),
                title: Text("Delete"),
                onTap: () {
                  provider.deleteNote(note);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              ListTile(
                leading: Icon(Icons.copy_rounded),
                title: Text("Copy"),
                onTap: () {
                  provider.insertNote(note);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share"),
                onTap: () {
                  Share.share(note.note);
                },
              ),
              ColorsListView(),
            ],
          ),
        );
      },
    );
  }
}
