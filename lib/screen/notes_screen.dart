import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:notes_app/model/Note.dart';
import 'package:notes_app/model/note_provider.dart';
import 'package:notes_app/model/search_query_state.dart';
import 'package:notes_app/screen/add_note_screen.dart';
import 'package:notes_app/widgets/notes_list.dart';
import 'package:notes_app/widgets/search_box.dart';
import 'package:provider/provider.dart';

class Notes extends StatelessWidget {
  static const String ROUTE_ID = "notes-screen";

  @override
  Widget build(BuildContext context) {
    final SearchQuery query = context.watch<SearchQuery>();
    final NoteProvider provider = context.watch<NoteProvider>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNote.ROUTE_ID);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getNotes(provider, query.query),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: SearchBox(),
                    floating: true,
                    backgroundColor: Color(0x00000000),
                  ),
                  NotesList(snapshot.data),
                ],
              );
            else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<List<Note>> getNotes(NoteProvider provider, String query) async {
    return await provider.getNotes(query);
  }
}
