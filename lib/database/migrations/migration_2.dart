import 'package:sqflite/sqflite.dart';

class Migration2 {
  Future<void> upgrade(Database db) async {
    await db.execute('''
      ALTER TABLE todos
      ADD COLUMN priority INTEGER DEFAULT 0
    ''');

    await db.execute('''
      CREATE INDEX idx_todo_priority ON todos(priority)
    ''');
  }
}
