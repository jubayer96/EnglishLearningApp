import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user.dart';

class DBHelper {
  static Database _db;
  static const String email = 'email';
  static const String pass = 'pass';
  static const String name = 'name';
  static const String type = 'type';
  static const int beginnerMark = 0;
  static const int intermediateMark = 0;
  static const int advancedMark = 0;
  static const String TABLE = 'User';
  static const String DB_NAME = 'user.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    final db = openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user(email TEXT PRIMARY KEY, pass TEXT, name TEXT, type TEXT, beginnerMark INTEGER, intermediateMark INTEGER, advancedMark INTEGER)",
        );
      },
      version: 1,
    );
    return db;
  }

  Future<User> insert(User user) async {
    final Database dbClient = await db;
    await dbClient.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user;
  }

  Future<List<User>> getUser() async {
    final Database dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('user');

    return List.generate(maps.length, (i) {
      return User(
        email: maps[i]['email'],
        pass: maps[i]['pass'],
        name: maps[i]['name'],
        type: maps[i]['type'],
        beginnerMark: maps[i]['beginnerMark'],
        intermediateMark: maps[i]['intermediateMark'],
        advancedMark: maps[i]['advancedMark'],
      );
    });
  }

  // Future<int> delete(int id) async {
  //   var dbClient = await db;
  //   return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  // }

  Future<int> update(User user) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, user.toMap(),
        where: '$email = ?', whereArgs: [user.email]);
  }

  Future close() async {
    final Database dbClient = await db;
    dbClient.close();
  }
}
