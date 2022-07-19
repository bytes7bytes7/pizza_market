import 'models/models.dart';

abstract class DBHelper {
  const DBHelper();

  Future<void> createTable(String table, List<Field> fields);

  Future<void> clearTable(String table);

  Future<void> recreateTable(String table, List<Field> fields);

  Future<void> add(String table, List<Map<String, Object?>> data);

  Future<void> update(
    String table,
    List<Map<String, Object?>> data, {
    List<Map<String, Object?>>? where,
  });

  Future<List<Map<String, Object?>>> read(
    String table, {
    Map<String, Object?>? where,
  });

  Future<void> delete(
    String table, {
    Map<String, Object?>? where,
  });
}
