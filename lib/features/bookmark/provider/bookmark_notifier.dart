import 'package:bookshop/features/bookmark/database/bookmark_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/bookmark_db.dart';
import 'bookmark_provider.dart';

class BookmarkNotifier extends AsyncNotifier<void> {
  BookmarkDb? database;

  @override
  Future<void> build() async {
    database ??= await ref.watch(databaseProvider.future);
  }

  Future<void> toggleLevelBookmark(
      LevelBookmarkEntity levelBookmark, bool isBookmarked) async {
    database ??= await ref.watch(databaseProvider.future);

    state = const AsyncLoading();

    if (isBookmarked) {
      await database!.bookmarkDao.deleteBookmarkedLevel(levelBookmark.levelNum);
    } else {
      await database!.bookmarkDao.addLevelInBookmark(levelBookmark);
    }

    ref.invalidate(getBookmarkedLevel);
    ref.invalidate(getBookmarkByLevelIdProvider(levelBookmark.levelNum));
    state = const AsyncData(null);
  }

  Future<void> toggleWordBookmark(
      WordBookmarkEntity wordBookmark, bool isBookmarked) async {
    database ??= await ref.watch(databaseProvider.future);

    state = const AsyncLoading();

    if (isBookmarked) {
      await database!.bookmarkDao.deleteBookmarkedWord(wordBookmark.serialNum);
    } else {
      await database!.bookmarkDao.addWrodInBookmark(wordBookmark);
    }

    ref.invalidate(getBookmarkedWord);
    state = const AsyncData(null);
  }
}
