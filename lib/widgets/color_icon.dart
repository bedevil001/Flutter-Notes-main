import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes_app/model/note_color_state.dart';
import 'package:provider/provider.dart';

class ColorIcon extends StatelessWidget {
  final Color color;

  ColorIcon({this.color});

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteColor>(
      builder: (context, value, child) {
        return ButtonTheme(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minWidth: 0,
          height: 0,
          padding: EdgeInsets.zero,
          child: FlatButton(
            onPressed: () {
              value.changeColor(color);
            },
            child: Container(
             margin: EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(1.0),
              child: CircleAvatar(
                backgroundColor: color,
                radius: 15,
                child: value.color == color ? addIcon() : null,
              ),
              decoration: new BoxDecoration(
                color: Colors.black45, // border color
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget addIcon() {
    return Icon(
      Icons.done,
      color: Colors.black45,
    );
  }
}
