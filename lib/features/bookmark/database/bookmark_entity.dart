import 'package:floor/floor.dart';

@Entity(tableName: 'level_bookmark')
class BookmarkEntity {
  @primaryKey
  @ColumnInfo(name: 'level_num')
  final int levelNum;

  BookmarkEntity(this.levelNum);
}
