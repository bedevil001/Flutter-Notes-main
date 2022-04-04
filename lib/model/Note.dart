class Note {
  String id;
  String title;
  String note;
  int time;
  int color;

  Note({this.title, this.note, this.color});

  Note.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.title = map["title"];
    this.note = map["note"];
    this.time = map["time"];
    this.color = map["color"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "note": note,
      "time": time,
      "color": color
    };
  }

  @override
  bool operator ==(Object other) {
    if (other != null && other is Note) {
      return id == other.id &&
          title == other.title &&
          note == other.note &&
          color == other.color;
    }
    return false;
  }

  @override
  int get hashCode => id.hashCode;

}
