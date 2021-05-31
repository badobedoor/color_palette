import 'dart:math';

import 'package:color_palette/models/FavoriteListColors.dart';
import 'package:color_palette/models/colores.dart';
import 'package:color_palette/providers/color_provider.dart';
import 'package:color_palette/utils/Color_database_helper.dart';
import 'package:color_palette/utils/Favorite_list_Color_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/Home_Screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Colores> coloresList = [];
  // int count = 0;
  @override
  final key = new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    // if (coloresList.isEmpty == true) {
    //   coloresList = <Colores>[];
    //   updateListView();
    // }
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    int nomberOfPalete = Provider.of<ColorProvider>(context, listen: true)
        .colors_palette_numbers;
    var listColorPalet =
        Provider.of<ColorProvider>(context, listen: true).color;
    // List<List<ColorPalet>> b = [];
    Color primaryColor = Theme.of(context).primaryColor;
    String colorsType =
        Provider.of<ColorProvider>(context, listen: true).colors_palette_type;
    String colorsHexText =
        Provider.of<ColorProvider>(context, listen: true).colorsHexText;
    String colorNomberText =
        Provider.of<ColorProvider>(context, listen: true).colorsNomberText;
    int id = Provider.of<ColorProvider>(context, listen: true).id;
    Widget iconButtons(Icon icon, Function fun) {
      return IconButton(
        icon: icon,
        color: Colors.white,
        onPressed: () {
          fun();
        },
      );
    }

    Widget iconChange(Function fun) {
      Icon ic = Icon(Icons.lock);
      listColorPalet.forEach((element) {
        if (element.title == colorsHexText) {
          ic = element.look == 1 ? Icon(Icons.lock) : Icon(Icons.lock_open);
        }
      });
      return IconButton(
        icon: ic,
        color: Colors.white,
        onPressed: () {
          fun();
        },
      );
    }
    //  IconData iconNChange() {

    //     return Icons.ac_unit_outlined;
    //   });
    // }

    return Scaffold(
      key: key,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 29),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 35,
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 5),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Text(
                      'رجوع',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 25.0, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 30, top: 10),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: primaryColor,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Text(
              'واحة الالوان',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 35.0,
                  ),
            ),
            SizedBox(height: 50),
            Container(
              width: dw - 60,
              //margin: EdgeInsets.symmetric(horizontal: 30),
              height: 130,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: listColorPalet
                    .map(
                      (catData) => Expanded(
                        child: InkWell(
                          onTap: () {
                            // الى انت عاوز تعمله لما تختار لون
                            Provider.of<ColorProvider>(context, listen: false)
                                .colorsTextChange(
                                    catData.hexColor, catData.title, 5);

                            listColorPalet.forEach((element) {
                              if (catData.title != element.title) {
                                if (element.look == 0) {
                                  if (element.chose == 1) {
                                    //تحديث الليست بتاعت الالوان
                                    element.chose = 0;
                                  }
                                }
                              } else {
                                if (catData.look == 0) {
                                  if (catData.chose == 0) {
                                    catData.chose = 1;
                                  } else {
                                    catData.chose = 1;
                                  }
                                }
                              }
                            });
                            //تحديث الليست بتاعت الالوان

                            Provider.of<ColorProvider>(context, listen: false)
                                .colorsListChange(listColorPalet);
                          },
                          splashColor: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: [
                              Container(
                                width: ((dw - 60) / nomberOfPalete) - 2,
                                height: 130,
                                //if (isLandscape)
                                decoration: BoxDecoration(
                                  boxShadow: catData.chose == 0
                                      ? null
                                      : [
                                          BoxShadow(
                                            color: Colors.black45,
                                            spreadRadius: 0,
                                            blurRadius: 7,
                                            offset: Offset(0, -3),
                                          ),
                                        ],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        (((dw - 60) / nomberOfPalete) - 2) / 2),
                                    topRight: Radius.circular(
                                        (((dw - 60) / nomberOfPalete) - 2) / 2),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                  color: colorConvert(catData.rgbColor
                                      .toString()), //catData.rgbColor,
                                ),
                                margin: EdgeInsets.only(
                                    top: catData.chose == 1 ? 20 : 0,
                                    bottom: catData.chose == 1 ? 0 : 5,
                                    right: 1,
                                    left: 1),
                              ),
                              if (catData.look == 1)
                                Positioned(
                                  right:
                                      (((dw - 60) / nomberOfPalete) - 2) / 2 -
                                          10,
                                  top: 35,
                                  child: Icon(
                                    Icons.lock,
                                    color: primaryColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            //bottons**********************************************
            Container(
              width: dw - 60,
              child: Column(
                children: [
                  Container(
                    width: dw - 60,
                    height: 55,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white10,
                            spreadRadius: 5,
                            blurRadius: 5),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        iconButtons(Icon(Icons.settings_outlined), () {}),
                        iconChange(() {
                          listColorPalet.forEach((element) {
                            if (element.title == colorsHexText) {
                              if (element.look == 1) {
                                element.look = 0;
                                //element.select = false;
                              } else {
                                element.look = 1;
                                //element.select = true;
                              }
                            }
                          });
                          Provider.of<ColorProvider>(context, listen: false)
                              .colorsListChange(listColorPalet);
                        }),
                        iconButtons(
                            Icon(
                              Icons.autorenew,
                              size: 35,
                            ), () {
                          Provider.of<ColorProvider>(context, listen: false)
                              .editRodomColor(colorsType);
                          Provider.of<ColorProvider>(context, listen: false)
                              .colorsTextChange('', '', '');
                        }),
                        iconButtons(Icon(Icons.palette_outlined), () {}),
                        iconButtons(Icon(Icons.favorite_border), () async {
                          FavoriteListColors favoriteColors =
                              new FavoriteListColors(
                                  colorsType, nomberOfPalete);

                          int res = await _saveFavoriteColors(favoriteColors);
                          //futureRes.then((value) => res = value);
                          if (res != 0) {
                            listColorPalet.forEach((element) async {
                              element.title = element.title;
                              element.look = 0;
                              element.chose = 0;
                              element.rgbColor = element.rgbColor;
                              element.hexColor = element.hexColor;
                              element.colorPaletId = res;
                              await _saveColor(element);
                            });
                            _showAlertDialog('Don', 'Data Saving Secessfully');
                          }
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
                  Text(
                    '$colorsHexText',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 30.0,
                        ),
                  ),
                  SizedBox(height: 60),
                  new GestureDetector(
                      child: new Text(
                        '$colorNomberText',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 30.0,
                            ),
                      ),
                      onTap: () {
                        Clipboard.setData(
                            new ClipboardData(text: '$colorNomberText'));
                      }),
                ],
              ),
            ),
            Expanded(
              child: new Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: dw - 60,
                    height: 50,
                    //margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  //data base .....................................................................

  ColorDatabaseHelper colorhelper = ColorDatabaseHelper();
  FavoriteListColordatabasehelper favoriteColorhelper =
      FavoriteListColordatabasehelper();
  //late Colores colores;
  Color colorConvert(String color) {
    var hextext = (color.replaceRange(0, 6, '')).replaceFirst(')', '');
    var s = Color(int.parse(hextext));
    return Color(int.parse(hextext));
  }

  // Save Favorite Color data to database
  Future<int> _saveFavoriteColors(FavoriteListColors favoritecolors) async {
    int result;
    result = await favoriteColorhelper.insertfavoriteColor(favoritecolors);

    if (result != 0) {
      // Success
      //الاصول ان هنا اجيب الاي دى بتاع الليست الى لسه منشائة وارجعه تانى فى الدالة دى
      //Toast.show('Note Saved Successfully', context);

      //Future<int> r = favoriteColorhelper.getfavoriteLastId();
      return result;
      // _showAlertDialog('Status', 'favoritecolors Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
      return 0;
    }
  }

  // Save Color data to database
  Future<int> _saveColor(Colores colores) async {
    int result;
    result = await colorhelper.insertColor(colores);

    if (result != 0) {
      // Success
      //Toast.show('Note Saved Successfully', context);
      // _showAlertDialog('Status', 'Color Saved Successfully');
      return result;
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
      return 0;
    }
  }

  // void _delete() async {
  //   // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
  //   // the detail page by pressing the FAB of NoteList page.
  //   if (note.id == null) {
  //     Toast.show('No Note was add to deleted', context);
  //     return;
  //   }

  //   // Case 2: User is trying to delete the old note that already has a valid ID.
  //   int result = await helper.deleteNote(note.id);
  //   if (result != 0) {
  //     Toast.show('Note Deleted Successfully', context);
  //   } else {
  //     _showAlertDialog('Status', 'Error Occured while Deleting Note');
  //   }
  // }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  // void updateListView() {
  //   final Future<Database> dbFuture = colorhelper.initializeDatabase();
  //   dbFuture.then((database) {
  //     Future<List<Colores>> coloresListFuture = colorhelper.getcolorList();
  //     coloresListFuture.then((noteList) {
  //       setState(() {
  //         this.coloresList = noteList;
  //         this.count = noteList.length;
  //       });
  //     });
  //   });
  // }
}
