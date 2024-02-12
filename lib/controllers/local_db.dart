
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../utils/constants.dart';

class LocalDBController {
  Future<Database> _initDatabase() async {
    String path = p.join(await getDatabasesPath(), kDbName);
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await _creatDb(db, kTableName);
    });
  }

  Future _creatDb(Database db, String tabelName) async {
    await db.execute('''
create table $tabelName (
  $kId integer primary key autoincrement,
  $kCheckSaved text not null,
  $kUrlImage text not null,
  $kHeight integer not null,
  $kWidth integer not null
  )
''');
  }

  Future<int> setDataToDataBase({
    required Map<String, dynamic> map,
  }) async {
    final db = await _initDatabase();
    return await db.insert(kTableName, map,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future readData() async {
    final db = await _initDatabase();
    List<Map<String, dynamic>> data = await db.query(kTableName);
    return data;
  }

  Future<int> deleteOneItem({
    required int idItem,
  }) async {
    final db = await _initDatabase();
    return await db.delete(kTableName, where: '$kId = ?', whereArgs: [idItem]);
  }

  Future deleteAll() async {
    final dbPath = await getDatabasesPath();
    String path = p.join(dbPath, kDbName);
    await deleteDatabase(path);
  }
}
