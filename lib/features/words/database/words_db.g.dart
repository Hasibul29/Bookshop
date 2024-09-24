// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'words_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $WordsDbBuilderContract {
  /// Adds migrations to the builder.
  $WordsDbBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $WordsDbBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<WordsDb> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorWordsDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $WordsDbBuilderContract databaseBuilder(String name) =>
      _$WordsDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $WordsDbBuilderContract inMemoryDatabaseBuilder() =>
      _$WordsDbBuilder(null);
}

class _$WordsDbBuilder implements $WordsDbBuilderContract {
  _$WordsDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $WordsDbBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $WordsDbBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<WordsDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$WordsDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$WordsDb extends WordsDb {
  _$WordsDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WordsDao? _wordsDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `levels` (`level_num` INTEGER NOT NULL, `level_title` TEXT NOT NULL, PRIMARY KEY (`level_num`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `words` (`level_num` INTEGER NOT NULL, `serial_num` INTEGER NOT NULL, `arabic` TEXT NOT NULL, `english` TEXT NOT NULL, FOREIGN KEY (`level_num`) REFERENCES `levels` (`level_num`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`serial_num`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WordsDao get wordsDao {
    return _wordsDaoInstance ??= _$WordsDao(database, changeListener);
  }
}

class _$WordsDao extends WordsDao {
  _$WordsDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<LevelsEntity>> findAllLevels() async {
    return _queryAdapter.queryList('SELECT * FROM levels',
        mapper: (Map<String, Object?> row) => LevelsEntity(
            row['level_num'] as int, row['level_title'] as String));
  }

  @override
  Future<List<WordsEntity>> findWordsByLevel(int levelNum) async {
    return _queryAdapter.queryList('SELECT * FROM words WHERE level_num = ?1',
        mapper: (Map<String, Object?> row) => WordsEntity(
            row['level_num'] as int,
            row['serial_num'] as int,
            row['arabic'] as String,
            row['english'] as String),
        arguments: [levelNum]);
  }
}
