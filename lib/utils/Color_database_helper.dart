import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/colores.dart';

class ColorDatabaseHelper {
  static ColorDatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String colorTable = 'colorTable_table';
  String colId = 'id';
  String colTitle = 'title';
  String collook = 'look';
  String colchose = 'chose';
  String colrgbColor = 'rgbColor';
  String colhexColor = 'hexColor';
  String colorPaletId = 'colorPaletId';

  ColorDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory ColorDatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = ColorDatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'colorPalet.db';

    // Open/create the database at a given path
    var colorDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return colorDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    var s = await db.execute(
        'CREATE TABLE $colorTable($colId INTEGER PRIMARY KEY , $colTitle TEXT, '
        '$collook INTEGER, $colchose INTEGER , $colrgbColor TEXT, $colhexColor TEXT , $colorPaletId INTEGER)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getcolorMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(colorTable);
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertColor(Colores color) async {
    Database db = await this.database;
    var result = await db.insert(colorTable, color.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateColor(Colores color) async {
    var db = await this.database;
    var result = await db.update(colorTable, color.toMap(),
        where: '$colId = ?', whereArgs: [color.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteColor(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $colorTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $colorTable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Colores>> getcolorList() async {
    var colorMapList = await getcolorMapList(); // Get 'Map List' from database
    int count =
        colorMapList.length; // Count the number of map entries in db table

    List<Colores> colorList = <Colores>[];

    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      colorList.add(Colores.fromMapObject(colorMapList[i]));
    }

    return colorList;
  }

//هنا نهاية الشغل الباقى دا تجريبي
  void getlistOfcolorList(List<int> paletId) {
    Future<List<Colores>> x = getcolorList();
    List<List<Colores>> listcolorPaletList = <List<Colores>>[];
    paletId.forEach((id) {
      List<Colores> colorPaletList = <Colores>[];
      x.then((paletList) => paletList.forEach((color) {
            if (color.colorPaletId == id) {
              colorPaletList.add(color);
            }
          }));
      //لسه جزء الid
      //انى اضيف id للسته الكبيرة
      Map<String, dynamic> testmap;

      // Convert a Note object into a Map object
      Map<String, dynamic> toMap() {
        var map = Map<String, dynamic>();
        map['id'] = id;
        map['colorPalet'] = colorPaletList;
        return map;
      }
      // Extract a Note object from a Map object

      listcolorPaletList.add(colorPaletList);
    });
  }
}
// Future<List> queryAll() async {
//   Database db = await database;
//   List<Map> names = await db.rawQuery(
//       'select Name.name, count(Date.date) from Name left join Date using(id) group by Name.name');
//   if (names.length > 0) {
//     return names;
//   }
//   return null;
// }
