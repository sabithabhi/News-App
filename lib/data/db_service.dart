import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'dart:async';
import 'package:path/path.dart';

class DbService {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    String dbDirectory = await getDatabasesPath();
    String path = join(dbDirectory, 'favorites.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE favorites (title TEXT, description TEXT, url TEXT, urlToImage TEXT)');
  }

  Future<int> saveFavorite(Map<String, dynamic> favorite) async {
    var dbClient = await db;
    int res = await dbClient.insert("favorites", favorite);
    return res;
  }

  Future<List<Map>> getFavorites() async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("favorites");
    return res;
  }

  Future<int> deleteFavorite(String url) async {
    var dbClient = await db;
    int res =
        await dbClient.delete("favorites", where: "url = ?", whereArgs: [url]);
    return res;
  }
}
