import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'constants.dart' as db_const;
import 'db_helper.dart';
import 'models/models.dart';

class DBHelperImpl implements DBHelper {
  Database? _db;

  Future<Database> get database async {
    var db = _db;
    if (db != null) {
      return db;
    }

    _db = db = await _createDatabase();

    return db;
  }

  Future<Database> _createDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, db_const.dbName);
    final db = await openDatabase(
      path,
      version: db_const.version,
    );
    // IMPORTANT: this line disables journal_mode
    await db.rawQuery('PRAGMA JOURNAL_MODE = DELETE');
    return db;
  }

  @override
  Future<void> createTable(String table, List<Field> fields) async {
    final db = await database;
    var sql = StringBuffer('CREATE TABLE IF NOT EXISTS $table (');
    for (var e in fields) {
      var type = '';
      switch (e.type) {
        case int:
          type = 'INTEGER';
          break;
        case String:
          type = 'TEXT';
          break;
        case double:
          type = 'REAL';
          break;
      }

      if (e.primary) {
        type += ' PRIMARY KEY';
      }

      final nullable = e.nullable ? '' : 'NOT NULL';

      sql.write('${e.title} $type $nullable,');
    }

    sql = StringBuffer('${sql.toString().substring(0, sql.length - 1)})');

    await db.execute(sql.toString());
  }

  @override
  Future<void> clearTable(String table) async {
    final db = await database;
    await db.execute('DELETE FROM $table;');
  }

  @override
  Future<void> recreateTable(String table, List<Field> fields) async {
    final db = await database;
    await db.execute('DROP TABLE IF EXISTS $table;');
    await createTable(table, fields);
  }

  @override
  Future<void> add(String table, List<Map<String, Object?>> data) async {
    final db = await database;

    for (final e in data) {
      await db.insert(table, e);
    }
  }

  @override
  Future<void> update(
    String table,
    List<Map<String, Object?>> data, {
    List<Map<String, Object?>>? where,
  }) async {
    final db = await database;

    for (var i = 0; i < data.length; i++) {
      final map = data[i];
      final w = where?[i];
      final str = w?.keys.map((e) => '$e = ?').join(', ');

      await db.update(table, map, where: str, whereArgs: w?.values.toList());
    }
  }

  @override
  Future<List<Map<String, Object?>>> read(
    String table, {
    Map<String, Object?>? where,
  }) async {
    final db = await database;
    final str = where?.keys.map((e) => '$e = ?').join(', ');

    return db.query(table, where: str, whereArgs: where?.values.toList());
  }

  @override
  Future<void> delete(
    String table, {
    Map<String, Object?>? where,
  }) async {
    final db = await database;
    final str = where?.keys.map((e) => '$e = ?').join(', ');

    await db.delete(table, where: str, whereArgs: where?.values.toList());
  }
}
