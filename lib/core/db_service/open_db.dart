import 'package:floor/floor.dart';

import 'db_initialize.dart';

Future<T> openDatabase<T extends FloorDatabase>(
    String dbFileName, Future<T> Function(String) databaseBuilder) async {
  final dbFile = await copyDatabaseFromAssets(dbFileName);
  final database = await databaseBuilder(dbFile.path);
  return database;
}
