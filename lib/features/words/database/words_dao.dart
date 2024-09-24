import 'package:bookshop/features/words/database/words_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class WordsDao {
  @Query('SELECT * FROM levels')
  Future<List<LevelsEntity>> findAllLevels();

  @Query('SELECT * FROM words WHERE level_num = :levelNum')
  Future<List<WordsEntity>> findWordsByLevel(int levelNum);
}
