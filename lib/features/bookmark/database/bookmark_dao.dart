import 'package:floor/floor.dart';

import 'bookmark_entity.dart';

@dao
abstract class BookmarkDao {
  @Query('SELECT * FROM level_bookmark')
  Future<List<LevelBookmarkEntity>> getBookmarkedLevel();

  @Query('SELECT * FROM level_bookmark WHERE level_num = :levelNum')
  Future<LevelBookmarkEntity?> getBookmarkByLevelId(int levelNum);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addLevelInBookmark(LevelBookmarkEntity levelBookmark);

  @Query('DELETE FROM level_bookmark WHERE level_num = :levelNum')
  Future<void> deleteBookmarkedLevel(int levelNum);

  @Query('SELECT * FROM word_bookmark')
  Future<List<WordBookmarkEntity>> getBookmarkedWord();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addWrodInBookmark(WordBookmarkEntity wordBookmark);

  @Query('DELETE FROM word_bookmark WHERE serial_num = :serialNum')
  Future<void> deleteBookmarkedWord(int serialNum);
}
