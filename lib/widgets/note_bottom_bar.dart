import 'package:flutter/material.dart';
import 'package:notes_app/model/Note.dart';

import 'note_popup_menu.dart';
class BottomBar extends StatelessWidget {
  final String time;
  final Note note;
  const BottomBar({Key key, this.time, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 40),
            child: Text(
              "Edited $time",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return SingleChildScrollView(child: NotePopupMenu(note: note,));
                },
              );
            })
      ],
    );
  }

}