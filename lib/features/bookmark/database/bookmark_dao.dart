import 'package:bookshop/features/bookmark/database/bookmark_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class BookmarkDao {
  @Query('SELECT * FROM level_bookmark')
  Future<List<LevelBookmarkEntity>> getBookmarkedLevel();

  @Query('SELECT * FROM level_bookmark WHERE level_num = :levelNum')
  Future<LevelBookmarkEntity?> getBookmarkByLevelId(int levelNum);

  @Query('INSERT INTO level_bookmark (level_num) VALUES (:levelNum)')
  Future<void> addLevelIdInBookmark(int levelNum);

  @Query('DELETE FROM level_bookmark WHERE level_num = :levelNum')
  Future<void> deleteBookmarkedLevel(int levelNum);

  @Query('SELECT * FROM word_bookmark')
  Future<List<WordBookmarkEntity>> getBookmarkedWord();

  @Query(
      'INSERT INTO word_bookmark (serial_num) VALUES (:serialNum) ON CONFLICT (serial_num) DO NOTHING')
  Future<void> addWrodInBookmark(int serialNum);

  @Query('DELETE FROM word_bookmark WHERE serial_num = :serialNum')
  Future<void> deleteBookmarkedWord(int serialNum);
}
