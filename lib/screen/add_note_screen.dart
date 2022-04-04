import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/model/Note.dart';
import 'package:notes_app/model/note_color_state.dart';
import 'package:notes_app/model/note_provider.dart';
import 'package:notes_app/utils/const.dart';
import 'package:notes_app/widgets/note_bottom_bar.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  static const String ROUTE_ID = "add-note-screen";

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String title;

  String noteText;

  bool updateMode;

  int time;

  Note note;

  Color noteColor;

  @override
  void initState() {
    super.initState();
    updateMode = false;
    time = DateTime.now().millisecondsSinceEpoch;
    noteColor =Color(kColors[0]);
  }

  @override
  Widget build(BuildContext context) {
    final NoteProvider provider = context.read<NoteProvider>();
    note = ModalRoute.of(context).settings.arguments;
    if (note != null) {
      title = note.title;
      noteText = note.note;
      updateMode = true;
      time = note.time;
      noteColor = Color(note.color);
    }

    return Consumer<NoteColor>(builder: (context, color, child) {
      if (noteColor != null) {
        color.color = noteColor;
        noteColor = null;
      }
      return WillPopScope(
        onWillPop: () async {
          insertOrUpdate(provider, color.color);
          return true;
        },
        child: Scaffold(
          backgroundColor: color.color,
          body: SafeArea(
            child: Card(
              color: color.color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      padding: EdgeInsets.only(left: 10, bottom: 40),
                      icon: Icon(Icons.arrow_back),
                      color: Colors.black45,
                      onPressed: () {
                        insertOrUpdate(provider, color.color);
                        Navigator.pop(context);
                      }),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: TextFormField(
                      initialValue: title,
                      onChanged: (val) {
                        title = val;
                      },
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Title",
                          hintStyle: TextStyle(color: Colors.black38)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: TextFormField(
                        initialValue: noteText,
                        expands: true,
                        onChanged: (val) {
                          noteText = val;
                        },
                        style: TextStyle(fontSize: 18),
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Note",
                          hintStyle: TextStyle(color: Colors.black38),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  BottomBar(
                    time: getFormattedDate(time),
                    note: note,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void insertOrUpdate(NoteProvider provider,Color noteColor) {
    if (!updateMode) {
      provider.insertNote(
          Note(title: title, note: noteText, color: noteColor.value));
    } else {
      note.title = title;
      note.note = noteText;
      note.color = noteColor.value;
      provider.updateNote(note);
    }
  }

  static String getFormattedDate(int time) {
    DateTime toFormat = DateTime.fromMillisecondsSinceEpoch(time);
    int diff = DateTime.now().millisecondsSinceEpoch - time;
    if (Duration(milliseconds: diff).inDays < 1)
      return DateFormat.jm().format(toFormat);
    return DateFormat.yMMMd('en_US').format(toFormat);
  }
}
