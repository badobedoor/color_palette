import 'package:color_palette/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'color_palette_settings_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/Welcome_Screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Provider.of<ColorProvider>(context, listen: false).getColorsNumbers();
    //Provider.of<ColorProvider>(context, listen: false).getColorType('warm');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 220.0,
                  height: 160.0,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    'واحة الالوان',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  child: Text(
                    "ابدأ",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 25.0, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                        ColorPaletteSettingsScreen.routeName);
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(15.0),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 100.0)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
