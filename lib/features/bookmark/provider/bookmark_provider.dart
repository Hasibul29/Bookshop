import 'package:bookshop/features/bookmark/database/bookmark_db.dart';
import 'package:bookshop/features/bookmark/database/bookmark_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db_service/open_db.dart';
import 'bookmark_notifier.dart';

final databaseProvider = FutureProvider<BookmarkDb>((ref) async {
  return await openDatabase<BookmarkDb>(
    'bookmark.db',
    (path) => $FloorBookmarkDb.databaseBuilder(path).build(),
  );
});

final getBookmarkedLevel =
    FutureProvider<List<LevelBookmarkEntity>>((ref) async {
  final database = await ref.watch(databaseProvider.future);
  return await database.bookmarkDao.getBookmarkedLevel();
});

final getBookmarkByLevelIdProvider =
    FutureProvider.family<LevelBookmarkEntity?, int>((ref, levelNum) async {
  final database = await ref.watch(databaseProvider.future);
  return await database.bookmarkDao.getBookmarkByLevelId(levelNum);
});

final getBookmarkedWord = FutureProvider<List<WordBookmarkEntity>>((ref) async {
  final database = await ref.watch(databaseProvider.future);
  return await database.bookmarkDao.getBookmarkedWord();
});

final bookmarkNotifierProvider =
    AsyncNotifierProvider<BookmarkNotifier, void>(() {
  return BookmarkNotifier();
});
