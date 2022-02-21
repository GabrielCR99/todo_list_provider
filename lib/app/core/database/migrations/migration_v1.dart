import 'package:sqflite_common/sqlite_api.dart';
import 'migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute(
      '''
  CREATE TABLE todo(
  id Integer primary key autoincrement,
  descricao VARCHAR(500) not null,
  data_hora datetime,
  finalizado integer
  )
''',
    );
  }

  @override
  void upgrade(Batch batch) {}
}
