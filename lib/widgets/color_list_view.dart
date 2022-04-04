import 'package:flutter/material.dart';
import 'package:notes_app/model/note_color_state.dart';
import 'package:notes_app/utils/const.dart';
import 'package:provider/provider.dart';
import 'color_icon.dart';

class ColorsListView extends StatelessWidget {
  final List<Widget> colorsList = List.generate(
      kColors.length,
      (index) => ColorIcon(
            color: Color(kColors[index]),
          ));

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteColor>(
      builder: (context, value, child) {
        return Container(
          color: value.color,
          width: double.infinity,
          height: 50,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: colorsList,
          ),
        );
      },
    );
  }
}
