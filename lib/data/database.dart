import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_level/data/task_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'taskLevel.db');

  return openDatabase(path, onCreate: (db, version) {
    db.execute(TaskDao.tableql);
  }, version: 1);
}
