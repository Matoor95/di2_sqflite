import 'dart:io';

import 'package:di2_sqflite/models/article.dart';
import 'package:di2_sqflite/models/itemList.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseClient {
  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return await createDatabase();
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationCacheDirectory();
    final path = join(directory.path, 'database.db');
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  onCreate(Database database, int version) async {
    // table 1 list ( id, name)
    await database.execute('''
CREATE TABLE list(
id INTEGER PRIMAARY KEY,
name TEXT NOT NULL
)
''');
// tablr 2 article ( id, name , price , image , shop, list)
    await database.execute('''
CREATE TABLE article (
id INTEGER PRIMAARY KEY,
name TEXT NOT NULL
price REAL,
shop TEXT,
image TEXT,
list INTEGER 
)
''');
  }
  // function pour afficher les listes

  Future<List<Itemlist>> allItems() async {
    Database db = await database;
    const query = " SELECT * FROM list";
    List<Map<String, dynamic>> mapList = await db.rawQuery(query);
    return mapList.map((map) => Itemlist.fromMap(map)).toList();
  }

  // function pour ajouter une list
  Future<bool> addItems(String text) async {
    Database db = await database;
    await db.insert('list', {"name": text});
    return true;
  }

// function pour afficher les articles d'un lkst
  Future<List<Article>> articleFromId(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList =
        await db.query('article', where: 'list=?', whereArgs: [id]);
    return mapList.map((map) => Article.fromMap(map)).toList();
  }

//function qui permet d'ajouter ou de modifier une article en verifiant l'existance de l'article
  Future<bool> upsert(Article article) async {
    Database db = await database;
    (article.id == null)
        ? article.id = await db.insert('article', article.toMap())
        : await db.update('article', article.toMap(),
            where: 'id =?', whereArgs: [article.id]);
    return true;
  }

  //supprimer liste et article associes
  Future<bool> removeItem(Itemlist itemList) async {
    Database db = await database;
    await db.delete('list', where: 'id = ?', whereArgs: [itemList.id]);
    //supprimer les atrticle associe a la list
    await db.delete('article', where: 'list = ?', whereArgs: [itemList.id]);
    return true;
  }
}
