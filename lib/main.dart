import 'package:flutter/material.dart';
import 'package:notes_app/model/note_provider.dart';
import 'package:notes_app/model/search_query_state.dart';
import 'package:notes_app/screen/add_note_screen.dart';
import 'package:notes_app/screen/notes_screen.dart';
import 'package:provider/provider.dart';

import 'model/note_color_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteProvider>(
          create: (context) => NoteProvider(),
        ),
        ChangeNotifierProvider<NoteColor>(
          create: (context) => NoteColor(),
        ),
        ChangeNotifierProvider<SearchQuery>(
          create: (context) => SearchQuery(),
        )
      ],
      child: MaterialApp(
        initialRoute: Notes.ROUTE_ID,
        routes: {
          Notes.ROUTE_ID: (context) => Notes(),
          AddNote.ROUTE_ID: (context) => AddNote(),
        },
      ),
    );
  }
}
