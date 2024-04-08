import 'package:sqflite/sqflite.dart';

import 'migration.dart';

final class MigrationV1 implements Migration {
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
  void upgrade(Batch batch) => ();
}
