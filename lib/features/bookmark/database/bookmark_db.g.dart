// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $BookmarkDbBuilderContract {
  /// Adds migrations to the builder.
  $BookmarkDbBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $BookmarkDbBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<BookmarkDb> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorBookmarkDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $BookmarkDbBuilderContract databaseBuilder(String name) =>
      _$BookmarkDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $BookmarkDbBuilderContract inMemoryDatabaseBuilder() =>
      _$BookmarkDbBuilder(null);
}

class _$BookmarkDbBuilder implements $BookmarkDbBuilderContract {
  _$BookmarkDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $BookmarkDbBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $BookmarkDbBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<BookmarkDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$BookmarkDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$BookmarkDb extends BookmarkDb {
  _$BookmarkDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BookmarkDao? _bookmarkDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `level_bookmark` (`level_num` INTEGER NOT NULL, `level_title` TEXT NOT NULL, PRIMARY KEY (`level_num`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `word_bookmark` (`serial_num` INTEGER NOT NULL, `arabic` TEXT NOT NULL, `english` TEXT NOT NULL, PRIMARY KEY (`serial_num`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `book_bookmark` (`id` TEXT NOT NULL, `book_image` TEXT NOT NULL, `book_cover_image` TEXT NOT NULL, `book_name` TEXT NOT NULL, `book_writer` TEXT NOT NULL, `book_status` TEXT NOT NULL, `book_available` TEXT NOT NULL, `book_notavailable` TEXT NOT NULL, `book_review` TEXT NOT NULL, `book_type` TEXT NOT NULL, `book_publisher` TEXT NOT NULL, `total_read` TEXT NOT NULL, `book_average_review` TEXT NOT NULL, `book_category` TEXT NOT NULL, `book_state` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BookmarkDao get bookmarkDao {
    return _bookmarkDaoInstance ??= _$BookmarkDao(database, changeListener);
  }
}

class _$BookmarkDao extends BookmarkDao {
  _$BookmarkDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _levelBookmarkEntityInsertionAdapter = InsertionAdapter(
            database,
            'level_bookmark',
            (LevelBookmarkEntity item) => <String, Object?>{
                  'level_num': item.levelNum,
                  'level_title': item.levelTitle
                }),
        _wordBookmarkEntityInsertionAdapter = InsertionAdapter(
            database,
            'word_bookmark',
            (WordBookmarkEntity item) => <String, Object?>{
                  'serial_num': item.serialNum,
                  'arabic': item.arabic,
                  'english': item.english
                }),
        _bookBookmarkEntityInsertionAdapter = InsertionAdapter(
            database,
            'book_bookmark',
            (BookBookmarkEntity item) => <String, Object?>{
                  'id': item.id,
                  'book_image': item.bookImage,
                  'book_cover_image': item.bookCoverImage,
                  'book_name': item.bookName,
                  'book_writer': item.bookWriter,
                  'book_status': item.bookStatus,
                  'book_available': item.bookAvailable,
                  'book_notavailable': item.bookNotAvailable,
                  'book_review': item.bookReview,
                  'book_type': item.bookType,
                  'book_publisher': item.bookPublisher,
                  'total_read': item.totalRead,
                  'book_average_review': item.bookAverageReview,
                  'book_category': item.bookCategory,
                  'book_state': item.bookState
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LevelBookmarkEntity>
      _levelBookmarkEntityInsertionAdapter;

  final InsertionAdapter<WordBookmarkEntity>
      _wordBookmarkEntityInsertionAdapter;

  final InsertionAdapter<BookBookmarkEntity>
      _bookBookmarkEntityInsertionAdapter;

  @override
  Future<List<LevelBookmarkEntity>> getBookmarkedLevel() async {
    return _queryAdapter.queryList('SELECT * FROM level_bookmark',
        mapper: (Map<String, Object?> row) => LevelBookmarkEntity(
            row['level_num'] as int, row['level_title'] as String));
  }

  @override
  Future<LevelBookmarkEntity?> getBookmarkByLevelId(int levelNum) async {
    return _queryAdapter.query(
        'SELECT * FROM level_bookmark WHERE level_num = ?1',
        mapper: (Map<String, Object?> row) => LevelBookmarkEntity(
            row['level_num'] as int, row['level_title'] as String),
        arguments: [levelNum]);
  }

  @override
  Future<void> deleteBookmarkedLevel(int levelNum) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM level_bookmark WHERE level_num = ?1',
        arguments: [levelNum]);
  }

  @override
  Future<List<WordBookmarkEntity>> getBookmarkedWord() async {
    return _queryAdapter.queryList('SELECT * FROM word_bookmark',
        mapper: (Map<String, Object?> row) => WordBookmarkEntity(
            row['serial_num'] as int,
            row['arabic'] as String,
            row['english'] as String));
  }

  @override
  Future<void> deleteBookmarkedWord(int serialNum) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM word_bookmark WHERE serial_num = ?1',
        arguments: [serialNum]);
  }

  @override
  Future<List<BookBookmarkEntity>> getBookmarkedBooks() async {
    return _queryAdapter.queryList('SELECT * FROM book_bookmark',
        mapper: (Map<String, Object?> row) => BookBookmarkEntity(
            id: row['id'] as String,
            bookImage: row['book_image'] as String,
            bookCoverImage: row['book_cover_image'] as String,
            bookName: row['book_name'] as String,
            bookWriter: row['book_writer'] as String,
            bookStatus: row['book_status'] as String,
            bookAvailable: row['book_available'] as String,
            bookNotAvailable: row['book_notavailable'] as String,
            bookReview: row['book_review'] as String,
            bookType: row['book_type'] as String,
            bookPublisher: row['book_publisher'] as String,
            totalRead: row['total_read'] as String,
            bookAverageReview: row['book_average_review'] as String,
            bookCategory: row['book_category'] as String,
            bookState: row['book_state'] as String));
  }

  @override
  Future<BookBookmarkEntity?> getBookmarkedBookById(String bookId) async {
    return _queryAdapter.query('SELECT * FROM book_bookmark WHERE id = ?1',
        mapper: (Map<String, Object?> row) => BookBookmarkEntity(
            id: row['id'] as String,
            bookImage: row['book_image'] as String,
            bookCoverImage: row['book_cover_image'] as String,
            bookName: row['book_name'] as String,
            bookWriter: row['book_writer'] as String,
            bookStatus: row['book_status'] as String,
            bookAvailable: row['book_available'] as String,
            bookNotAvailable: row['book_notavailable'] as String,
            bookReview: row['book_review'] as String,
            bookType: row['book_type'] as String,
            bookPublisher: row['book_publisher'] as String,
            totalRead: row['total_read'] as String,
            bookAverageReview: row['book_average_review'] as String,
            bookCategory: row['book_category'] as String,
            bookState: row['book_state'] as String),
        arguments: [bookId]);
  }

  @override
  Future<void> deleteBookmarkedBookById(String bookId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM book_bookmark WHERE id = ?1',
        arguments: [bookId]);
  }

  @override
  Future<void> addLevelInBookmark(LevelBookmarkEntity levelBookmark) async {
    await _levelBookmarkEntityInsertionAdapter.insert(
        levelBookmark, OnConflictStrategy.replace);
  }

  @override
  Future<void> addWrodInBookmark(WordBookmarkEntity wordBookmark) async {
    await _wordBookmarkEntityInsertionAdapter.insert(
        wordBookmark, OnConflictStrategy.replace);
  }

  @override
  Future<void> addBookInBookmark(BookBookmarkEntity book) async {
    await _bookBookmarkEntityInsertionAdapter.insert(
        book, OnConflictStrategy.replace);
  }
}
