import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

import 'sqlite_migration_factory.dart';

class SqliteConnectionFactory {
  static SqliteConnectionFactory? _instance;

  factory SqliteConnectionFactory() {
    _instance ??= SqliteConnectionFactory._();

    return _instance!;
  }
  SqliteConnectionFactory._();

  static const _version = 1;
  static const _databaseName = 'TODO_LIST_PROVIDER';

  final _lock = Lock();

  Database? _db;

  Future<Database> openConnection() async {
    final databasePath = await getDatabasesPath();
    final finalDatabasePath = join(databasePath, _databaseName);

    if (_db == null) {
      await _lock.synchronized(
        () async {
          _db ??= await openDatabase(
            finalDatabasePath,
            version: _version,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onDowngrade: _onDowngrade,
          );
        },
      );
    }

    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int _) async {
    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getCreateMigration();

    for (final migration in migrations) {
      migration.create(batch);
    }

    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int _) async {
    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);

    for (final migration in migrations) {
      migration.upgrade(batch);
    }

    batch.commit();
  }

  Future<void> _onDowngrade(Database _, int __, int ___) async => Never;
}
