import 'package:bookshop/features/words/database/words_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db_service/open_db.dart';
import '../database/words_entity.dart';

final databaseProvider = FutureProvider<WordsDb>((ref) async {
  return await openDatabase<WordsDb>(
    'app_database.db',
    (path) => $FloorWordsDb.databaseBuilder(path).build(),
  );
});

final levelsProvider = FutureProvider<List<LevelsEntity>>((ref) async {
  final database = await ref.watch(databaseProvider.future);
  return await database.wordsDao.findAllLevels();
});

final wordsByLevelProvider =
    FutureProvider.family<List<WordsEntity>, int>((ref, levelNum) async {
  final database = await ref.watch(databaseProvider.future);
  return await database.wordsDao.findWordsByLevel(levelNum);
});
