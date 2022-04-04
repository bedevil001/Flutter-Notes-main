import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/model/Note.dart';
import 'package:notes_app/widgets/note_card.dart';

class NotesList extends StatelessWidget {
  final List<Note> notes;

  NotesList(this.notes);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return SliverStaggeredGrid.countBuilder(
      crossAxisCount: 4,
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) {
        return NoteCard(notes[index]);
      },
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.fit(2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
