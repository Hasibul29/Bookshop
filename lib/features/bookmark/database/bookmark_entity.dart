import 'package:floor/floor.dart';

@Entity(tableName: 'level_bookmark')
class LevelBookmarkEntity {
  @primaryKey
  @ColumnInfo(name: 'level_num')
  final int levelNum;
  @ColumnInfo(name: 'level_title')
  final String levelTitle;

  LevelBookmarkEntity(this.levelNum, this.levelTitle);
}

@Entity(tableName: 'word_bookmark')
class WordBookmarkEntity {
  @primaryKey
  @ColumnInfo(name: 'serial_num')
  final int serialNum;
  final String arabic;
  final String english;

  WordBookmarkEntity(this.serialNum, this.arabic, this.english);
}
