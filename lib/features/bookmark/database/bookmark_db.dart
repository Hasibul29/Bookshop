import 'dart:async';
import 'package:bookshop/features/bookmark/database/bookmark_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'bookmark_dao.dart';

part 'bookmark_db.g.dart';

@Database(version: 1, entities: [LevelBookmarkEntity, WordBookmarkEntity])
abstract class BookmarkDb extends FloorDatabase {
  BookmarkDao get bookmarkDao;
}
