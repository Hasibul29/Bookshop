import 'dart:async';
import 'package:bookshop/features/words/database/words_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'words_dao.dart';

part 'words_db.g.dart';

@Database(version: 1, entities: [LevelsEntity, WordsEntity])
abstract class WordsDb extends FloorDatabase {
  WordsDao get wordsDao;
}
