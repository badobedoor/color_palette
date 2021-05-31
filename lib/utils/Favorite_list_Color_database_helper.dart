import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/FavoriteListColors.dart';

class FavoriteListColordatabasehelper {
  static FavoriteListColordatabasehelper?
      _favoriteListColordatabasehelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String favoriteListColorTable = 'favoriteTable_table';
  String colId = 'id';
  String colTitle = 'title';
  String colcolorPaletCount = 'colorPaletCount';
  String colorTable = 'colorTable_table';
  String colColorId = 'id';
  String colColorTitle = 'title';
  String collook = 'look';
  String colchose = 'chose';
  String colrgbColor = 'rgbColor';
  String colhexColor = 'hexColor';
  String colorPaletId = 'colorPaletId';

  FavoriteListColordatabasehelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory FavoriteListColordatabasehelper() {
    if (_favoriteListColordatabasehelper == null) {
      _favoriteListColordatabasehelper = FavoriteListColordatabasehelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _favoriteListColordatabasehelper!;
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
    var favoriteColorDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return favoriteColorDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $favoriteListColorTable($colId INTEGER PRIMARY KEY , $colTitle TEXT, '
        '$colcolorPaletCount INTEGER)');
    await db.execute(
        'CREATE TABLE $colorTable($colColorId INTEGER PRIMARY KEY , $colColorTitle TEXT, '
        '$collook INTEGER, $colchose INTEGER , $colrgbColor TEXT, $colhexColor TEXT , $colorPaletId INTEGER)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getfavoritecolorMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(favoriteListColorTable);
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertfavoriteColor(FavoriteListColors favoriteColor) async {
    Database db = await this.database;
    var result = await db.insert(favoriteListColorTable, favoriteColor.toMap());
    //   void updateListView() {
    // final Future<Database> dbFuture = colorhelper.initializeDatabase();
    // dbFuture.then((database) {
    //   Future<List<Colores>> coloresListFuture = colorhelper.getcolorList();
    //   coloresListFuture.then((noteList) {
    //     setState(() {
    //       this.coloresList = noteList;
    //       this.count = noteList.length;
    //     });
    //   });
    // });
    //}
    //هنا عاوز ارجع الاى دى ولو معرفتش اعمل دالة ترجعلى اخر id مضاف فى الليست
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updatefavoriteColor(FavoriteListColors favoriteColor) async {
    var db = await this.database;
    var result = await db.update(favoriteListColorTable, favoriteColor.toMap(),
        where: '$colId = ?', whereArgs: [favoriteColor.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deletefavoriteColor(int id) async {
    var db = await this.database;
    int result = await db
        .rawDelete('DELETE FROM $favoriteListColorTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getfavoriteCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $favoriteListColorTable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<FavoriteListColors>> getfavoritecolorList() async {
    var colorMapList =
        await getfavoritecolorMapList(); // Get 'Map List' from database
    int count =
        colorMapList.length; // Count the number of map entries in db table
    List<FavoriteListColors> colorList = <FavoriteListColors>[];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      colorList.add(FavoriteListColors.fromMapObject(colorMapList[i]));
    }
    colorList.last.id;
    return colorList;
  }

  Future<int> getfavoriteLastId() async {
    var colorMapList = await getfavoritecolorMapList();
    int count = colorMapList.length;
    List<FavoriteListColors> colorList = <FavoriteListColors>[];
    for (int i = 0; i < count; i++) {
      colorList.add(FavoriteListColors.fromMapObject(colorMapList[i]));
    }
    return colorList.last.id;
  }

//هنا نهاية الشغل الباقى دا تجريبي
  void getlistOffavoritecolorList(List<int> paletId) {
    Future<List<FavoriteListColors>> x = getfavoritecolorList();
    List<List<FavoriteListColors>> listcolorPaletList =
        <List<FavoriteListColors>>[];
    paletId.forEach((id) {
      List<FavoriteListColors> colorPaletList = <FavoriteListColors>[];
      x.then((paletList) => paletList.forEach((color) {
            if (color.id == id) {
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
