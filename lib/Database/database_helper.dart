import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "BlogsDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'favorite_blogs';

  static const columnId = 'id';
  static const columnName = 'title';
  static const columnAge = 'image_url';

  Database? _db;

  Future<void> init() async {
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId TEXT PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnAge TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    return await _db!.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db!.query(table);
  }

  Future<int> delete(String id) async {
    return await _db!.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
