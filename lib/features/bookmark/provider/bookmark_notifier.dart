import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/bookmark_db.dart';
import 'bookmark_provider.dart';

class BookmarkNotifier extends AsyncNotifier<void> {
  BookmarkDb? database;

  @override
  Future<void> build() async {
    database ??= await ref.watch(databaseProvider.future);
  }

  Future<void> toggleBookmark(int levelNum, bool isBookmarked) async {
    database ??= await ref.watch(databaseProvider.future);

    state = const AsyncLoading();

    if (isBookmarked) {
      await database!.bookmarkDao.deleteBookmarkedLevel(levelNum);
    } else {
      await database!.bookmarkDao.addLevelIdInBookmark(levelNum);
    }

    ref.invalidate(getBookmarkedLevel);
    ref.invalidate(getBookmarkByLevelIdProvider(levelNum));
    state = const AsyncData(null);
  }
}
