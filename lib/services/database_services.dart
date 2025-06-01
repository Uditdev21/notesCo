import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:notesco/models/notes_model.dart';

class DatabaseService {
  static Database? _database;
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<DatabaseService> init() async {
    await database; // Ensures database is initialized
    return this;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');
  }

  // Insert
  Future<int> insertNote(NotesModel note) async {
    final db = await database;
    return await db.insert('notes', note.toMap());
  }

  // Get all
  Future<List<NotesModel>> getNotes() async {
    final db = await database;

    final result = await db.query(
      'notes',
      orderBy: '''
      CASE 
        WHEN createdAt = updatedAt THEN createdAt
        ELSE updatedAt
      END DESC
    ''',
    );

    return result.map((e) => NotesModel.fromMap(e)).toList();
  }


  // Get one
  Future<NotesModel?> getNote(int id) async {
    final db = await database;
    final res = await db.query('notes', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? NotesModel.fromMap(res.first) : null;
  }

  Future<List<NotesModel>> searchNotesByTitle(String query) async {
    final db = await database;
    final result = await db.query(
      'notes',
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'createdAt DESC',
    );
    return result.map((e) => NotesModel.fromMap(e)).toList();
  }

  // Update
  Future<int> updateNote(NotesModel note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // Delete
  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
