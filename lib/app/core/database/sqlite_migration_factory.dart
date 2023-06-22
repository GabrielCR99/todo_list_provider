import 'migrations/migration.dart';
import 'migrations/migration_v1.dart';

final class SqliteMigrationFactory {
  List<Migration> getCreateMigration() => [MigrationV1()];

  List<Migration> getUpgradeMigration(int _) => const [];
}
