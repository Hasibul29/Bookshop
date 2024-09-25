import 'package:bookshop/features/bookmark/database/bookmark_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class BookmarkDao {
  @Query('SELECT * FROM level_bookmark')
  Future<List<BookmarkEntity>> getBookmarkedLevel();

  @Query('SELECT * FROM level_bookmark WHERE level_num = :levelNum')
  Future<BookmarkEntity?> getBookmarkByLevelId(int levelNum);

  @Query('INSERT INTO level_bookmark (level_num) VALUES (:levelNum)')
  Future<void> addLevelIdInBookmark(int levelNum);

  @Query('DELETE FROM level_bookmark WHERE level_num = :levelNum')
  Future<void> deleteBookmarkedLevel(int levelNum);
}
