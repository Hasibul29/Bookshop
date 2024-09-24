import 'package:floor/floor.dart';

@Entity(tableName: 'levels')
class LevelsEntity {
  @primaryKey
  @ColumnInfo(name: 'level_num')
  final int levelNum;

  @ColumnInfo(name: 'level_title')
  final String levelTitle;

  LevelsEntity(this.levelNum, this.levelTitle);
}

@Entity(
  tableName: 'words',
  foreignKeys: [
    ForeignKey(
        childColumns: ['level_num'],
        parentColumns: ['level_num'],
        entity: LevelsEntity,
        onDelete: ForeignKeyAction.cascade)
  ],
)
class WordsEntity {
  @ColumnInfo(name: 'level_num')
  final int levelNum;
  @primaryKey
  @ColumnInfo(name: 'serial_num')
  final int serialNum;

  final String arabic;
  final String english;

  WordsEntity(this.levelNum, this.serialNum, this.arabic, this.english);
}
