import 'package:flutter_sqlite/models/dog_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DogHelper {
//  DogHelper._();
//  static final DogHelper _db = DogHelper._();
//  factory DogHelper() => _db;
  static Database _database; //최초 한번만 데이터 베이스 세팅
  final String tableName = 'dogs';

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'dogDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY,
          name TEXT,
          age INTEGER
        )
       ''');
      },
    );
  }

  Future<List<Dog>> select() async {
    final db = await database;
    List<Map<String, dynamic>> dogs = await db.query(tableName);
    return List.generate(
      dogs.length,
      (i) {
        return Dog(
          id: dogs[i]['id']??0,
          name: dogs[i]['name']??'',
          age: dogs[i]['age']??0,
        );
      },
    );
  }

  Future<int> insert(Dog dog) async {
    final db = await database;
    return await db.insert(tableName, Dog(name: 'ggggg', age: 33).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> update(int id, Dog dog) async {
    final db = await database;
    return await db.update(tableName, dog.toMap(),
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll()async{
    final db = await database;
    return await db.rawDelete('DELETE FROM $tableName');
  }
}
