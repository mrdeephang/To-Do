import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:to_do/models/task.dart';
import 'migrations/migration_1.dart';
import 'migrations/migration_2.dart';

class TodoDatabase {
  static const _databaseName = 'todo_app.db';
  static const _databaseVersion = 1;

  // Singleton pattern
  static final TodoDatabase instance = TodoDatabase._init();
  Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await Migration1().createTables(db);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await Migration2().upgrade(db);
    }
  }

  // CRUD Operations
  Future<int> createTodo(TodoItem todo) async {
    final db = await instance.database;
    return await db.insert('todos', todo.toMap());
  }

  Future<List<TodoItem>> readAllTodos() async {
    final db = await instance.database;
    final result = await db.query('todos');
    return result.map((json) => TodoItem.fromMap(json)).toList();
  }

  Future<int> updateTodo(TodoItem todo) async {
    final db = await instance.database;
    return await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(String id) async {
    final db = await instance.database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
