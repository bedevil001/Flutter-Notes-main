import 'package:notes_app/model/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database _database;
  String _table = 'notes';
  int _version = 3;
  static final DatabaseHelper instance = DatabaseHelper._constructor();

  DatabaseHelper._constructor();

  Future<Database> get database async {
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), "notes.db"),
        onCreate: (db, version) => _createTable(db),
        onUpgrade: (db, oldVersion, newVersion) {
          db.execute("DROP TABLE IF EXISTS $_table;");
          _createTable(db);
        },
        version: _version,
      );
    }
    return _database;
  }

  init() async {}

  void _createTable(Database db) {
    db.execute(
        "CREATE TABLE $_table(id TEXT PRIMARY KEY,title TEXT,note  TEXT, color INTEGER, time INTEGER);");
  }

  Future<void> insert(Note note) async {
    Database db = await instance.database;
    await db.insert(_table, note.toMap());
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    Database db = await instance.database;
    return await db.query(_table);
  }

  Future<List<Map<String, dynamic>>> getByQuery(String query) async {
    Database db = await instance.database;
    return await db.rawQuery("SELECT * FROM $_table WHERE title LIKE '%$query%' OR note LIKE '%$query%';");
  }

  Future<int> update(Note note) async {
    Database db = await instance.database;
    return await db
        .update(_table, note.toMap(), where: "id = ?", whereArgs: [note.id]);
  }

  Future<Map<String, dynamic>> getNote(String id) async {
    Database db = await instance.database;

    return (await db.query(_table, where: "id = ?", whereArgs: [id]))[0];
  }

  Future<int> delete(String id) async {
    Database db = await instance.database;
    return await db.delete(_table, where: "id = ?", whereArgs: [id]);
  }
}
