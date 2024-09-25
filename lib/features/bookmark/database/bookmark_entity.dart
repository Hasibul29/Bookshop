import 'package:floor/floor.dart';

@Entity(tableName: 'level_bookmark')
class LevelBookmarkEntity {
  @primaryKey
  @ColumnInfo(name: 'level_num')
  final int levelNum;

  LevelBookmarkEntity(this.levelNum);
}

@Entity(tableName: 'word_bookmark')
class WordBookmarkEntity {
  @primaryKey
  @ColumnInfo(name: 'serial_num')
  final int serialNum;

  WordBookmarkEntity(this.serialNum);
}
