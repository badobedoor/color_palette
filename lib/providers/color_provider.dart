import 'dart:math';

import 'package:color_palette/models/colores.dart';
import 'package:color_palette/utils/Color_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorProvider with ChangeNotifier {
  int colors_palette_numbers = 3;
  String colors_palette_type = 'warm';
  List<Colores> color = [];
  String colorsHexText = '';
  String colorsNomberText = '';
  int id = 0;
  List<int> shadList = [50, 100, 200, 300, 400, 600, 700, 800, 900];
  List<MaterialColor> colorsList = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.amber,
    Colors.blue,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.grey,
    Colors.indigo,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.lime,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.teal,
  ];
  // onChanged(new_Colors_palette_numbers, n) async {

  //   notifyListeners();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  // }
  void colorspaletChange() async {
    notifyListeners();
  }

  MaterialColor setMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: Color(0xFFFFEBEE),
        100: Color(0xFFFFCDD2),
        200: Color(0xFFEF9A9A),
        300: Color(0xFFE57373),
        400: Color(0xFFEF5350),
        500: Color(colorVal),
        600: Color(0xFFE53935),
        700: Color(0xFFD32F2F),
        800: Color(0xFFC62828),
        900: Color(0xFFB71C1C),
      },
    );
  }

  int hexOfRGBA(int r, int g, int b, {double opacity = 1}) {
    r = (r < 0) ? -r : r;
    g = (g < 0) ? -g : g;
    b = (b < 0) ? -b : b;
    opacity = (opacity < 0) ? -opacity : opacity;
    opacity = (opacity > 1) ? 255 : opacity * 255;
    r = (r > 255) ? 255 : r;
    g = (g > 255) ? 255 : g;
    b = (b > 255) ? 255 : b;
    int a = opacity.toInt();
    return int.parse(
        '0x${a.toRadixString(16)}${r.toRadixString(16)}${g.toRadixString(16)}${b.toRadixString(16)}');
  }

  void colorsNumbersChange(new_Colors_palette_numbers) async {
    colors_palette_numbers = new_Colors_palette_numbers;

    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('ColorsPaletteNumbers', colors_palette_numbers);
  }

  getColorsNumbers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    colors_palette_numbers = prefs.getInt('ColorsPaletteNumbers') ?? 3;
    notifyListeners();
  }

  void colorsTypeChange(new_colors_palette_type) async {
    colors_palette_type = new_colors_palette_type;

    notifyListeners();
  }

  void colorsListChange(new_colors_List) async {
    color = new_colors_List;

    notifyListeners();
  }

  void colorsTextChange(new_ColorsHexText, new_colorsNomberText, new_id) async {
    colorsHexText = new_ColorsHexText;
    var hextext = new_colorsNomberText == ''
        ? ''
        : (new_colorsNomberText.replaceRange(0, 9, '#')).replaceFirst(')', '');
    colorsNomberText = hextext;
    id = new_id;

    notifyListeners();
  }

  getColorType(colorsType) {
    if (colorsType == 'warm') {
      return buildRodomHotColor();
    } else if (colorsType == 'cold') {
      return buildRodomColdColor();
    } else if (colorsType == 'dark') {
      return buildRodomdarkColor();
    } else if (colorsType == 'monochrome') {
      return buildRodommonochromeColor();
    } else if (colorsType == 'bright') {
      return buildRodomlightColor();
    } else {
      return buildRodomHotColor();
    }
    notifyListeners();
  }

  buildRodomHotColor() {
    random(min, max) {
      var rn = new Random();
      return min + rn.nextInt(max - min);
    }

    List<Colores> ac = [];
    for (var i = 0; i < colors_palette_numbers; i++) {
      var r = random(128, 255);
      var g = random(0, 255);
      var b = 0;
      Color colorFromRGB = Color.fromRGBO(r, g, b, 1.0);

      var newColor = new Colores(
          // '${DateTime.now()}${colorFromRGB.hashCode}',
          colorFromRGB.toString(),
          0,
          0,
          colorFromRGB.toString(),
          colorFromRGB.toString(),
          5);
      ac.add(newColor);
      //color_Palet.insert(i, newColorPalet);
    }
    color = ac;
    notifyListeners();
  }

  buildRodomColdColor() {
    random(min, max) {
      var rn = new Random();
      return min + rn.nextInt(max - min);
    }

    List<Colores> ac = [];
    for (var i = 1; i <= colors_palette_numbers; i++) {
      var r = 0;
      var g = random(0, 255);
      var b = random(128, 255);
      Color colorFromRGB = Color.fromRGBO(r, g, b, 1.0);
      var newColorPalet = new Colores(
          //'${DateTime.now()}${colorFromRGB.hashCode}',
          colorFromRGB.toString(),
          0,
          0,
          colorFromRGB.toString(),
          colorFromRGB.toString(),
          5);
      ac.add(newColorPalet);
    }
    color = ac;
    notifyListeners();
  }

  buildRodomdarkColor() {
    random(min, max) {
      var rn = new Random();
      return min + rn.nextInt(max - min);
    }

    List<Colores> ac = [];
    for (var i = 1; i <= colors_palette_numbers; i++) {
      var r = random(0, 125);
      var g = random(0, 125);
      var b = random(0, 125);
      Color colorFromRGB = Color.fromRGBO(r, g, b, 1.0);
      var newColorPalet = new Colores(
          //'${DateTime.now()}${colorFromRGB.hashCode}',
          colorFromRGB.toString(),
          0,
          0,
          colorFromRGB.toString(),
          colorFromRGB.toString(),
          5);
      ac.add(newColorPalet);
    }
    color = ac;
    notifyListeners();
  }

  buildRodomlightColor() {
    random(min, max) {
      var rn = new Random();
      return min + rn.nextInt(max - min);
    }

    List<Colores> ac = [];
    for (var i = 1; i <= colors_palette_numbers; i++) {
      var r = random(125, 250);
      var g = random(125, 250);
      var b = random(125, 250);
      Color colorFromRGB = Color.fromRGBO(r, g, b, 1.0);
      var newColorPalet = new Colores(
          //'${DateTime.now()}${colorFromRGB.hashCode}',
          colorFromRGB.toString(),
          0,
          0,
          colorFromRGB.toString(),
          colorFromRGB.toString(),
          5);
      ac.add(newColorPalet);
    }
    color = ac;
    notifyListeners();
  }

  buildRodommonochromeColor() {
    final _random = new Random();

    List<Colores> ac = [];

    MaterialColor paesColor = colorsList[_random.nextInt(colorsList.length)];
    for (int i = 1; i <= colors_palette_numbers; i++) {
      int shade = shadList[_random.nextInt(shadList.length)];
      Color? r = paesColor[shade];
      Colores newColorPalet = new Colores(
          //'${DateTime.now()}${paesColor[shade].hashCode}',
          paesColor[shade].toString(),
          0,
          0,
          paesColor[shade]!.toString(),
          paesColor[shade]!.toString(),
          5);
      ac.add(newColorPalet);
    }
    color = ac;
    notifyListeners();
  }

  editRodomColor(colorsType) {
    random(min, max) {
      var rn = new Random();
      return min + rn.nextInt(max - min);
    }

    final _random = new Random();
    int r = 0;
    int g = 0;
    int b = 0;
    int rmin = 0;
    int gmin = 0;
    int bmin = 0;
    int rmax = 0;
    int gmax = 0;
    int bmax = 0;

    MaterialColor paesColor = Colors.pink;

    editcolor(rmin, rmax, gmin, gmax, bmin, bmax, paesColor) {
      color.forEach((element) {
        if (rmin != 0 || rmax != 0) {
          r = random(rmin, rmax);
        }
        if (gmin != 0 || gmax != 0) {
          g = random(gmin, gmax);
        }
        if (bmin != 0 || bmax != 0) {
          b = random(bmin, bmax);
        }
        Color colorFromRGB = Color.fromRGBO(r, g, b, 1.0);
        int shade = shadList[_random.nextInt(shadList.length)];
        if (element.look != true) {
          // element.id = colorsType == 'monochrome'
          //     ? '${DateTime.now()}${paesColor[shade]!.hashCode}'
          //     : '${DateTime.now()}${Color.fromRGBO(r, g, b, 1.0).hashCode}';
          element.title = colorsType == 'monochrome'
              ? paesColor[shade]!.toString()
              : colorFromRGB.toString();
          element.look = element.look;
          element.chose = element.chose;
          element.rgbColor = colorsType == 'monochrome'
              ? paesColor[shade]!
              : colorFromRGB.toString();
          element.hexColor = colorsType == 'monochrome'
              ? paesColor[shade]!
              : colorFromRGB.toString();
        } else {
          //element.id = element.id;
          element.title = element.title;
          element.look = element.look;
          element.chose = element.chose;
          element.rgbColor = element.rgbColor;
          element.hexColor = element.hexColor;
        }
      });
    }

    if (colorsType == 'warm') {
      rmin = 128;
      rmax = 255;
      gmin = 0;
      gmax = 255;
      bmin = 0;
      bmax = 0;
      editcolor(rmin, rmax, gmin, gmax, bmin, bmax, paesColor);
    } else if (colorsType == 'cold') {
      rmin = 0;
      rmax = 0;
      gmin = 0;
      gmax = 250;
      bmin = 128;
      bmax = 250;
      editcolor(rmin, rmax, gmin, gmax, bmin, bmax, paesColor);
    } else if (colorsType == 'dark') {
      rmin = 0;
      rmax = 125;
      gmin = 0;
      gmax = 125;
      bmin = 0;
      bmax = 125;
      editcolor(rmin, rmax, gmin, gmax, bmin, bmax, paesColor);
    } else if (colorsType == 'monochrome') {
      paesColor = colorsList[_random.nextInt(colorsList.length)];
      editcolor(rmin, rmax, gmin, gmax, bmin, bmax, paesColor);
    } else if (colorsType == 'bright') {
      rmin = 125;
      rmax = 250;
      gmin = 125;
      gmax = 250;
      bmin = 125;
      bmax = 255;
      editcolor(rmin, rmax, gmin, gmax, bmin, bmax, paesColor);
    } else {
      rmin = 128;
      rmax = 255;
      gmin = 0;
      gmax = 255;
      bmin = 0;
      bmax = 0;
      editcolor(rmin, rmax, gmin, gmax, bmin, bmax, paesColor);
    }

    notifyListeners();
  }
}
