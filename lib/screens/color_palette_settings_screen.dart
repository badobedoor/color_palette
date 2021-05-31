import 'package:color_palette/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class ColorPaletteSettingsScreen extends StatelessWidget {
  static const routeName = '/Color_Palette_Settings_Screen';

  @override
  Widget buildListElevatedButton(
      BuildContext ctx, Color btColor, String colorType) {
    return ElevatedButton(
      onPressed: () async {
        Provider.of<ColorProvider>(ctx, listen: false)
            .colorsTypeChange(colorType);
        await Provider.of<ColorProvider>(ctx, listen: false)
            .getColorType(colorType);
        await Provider.of<ColorProvider>(ctx, listen: false)
            .editRodomColor(colorType);

        // await Provider.of<ColorProvider>(ctx, listen: false)
        //     .editRodomColor(colorType);
        Navigator.of(ctx).pushNamed(HomeScreen.routeName);
      },
      style: ElevatedButton.styleFrom(
        padding: colorType == 'bright' ? EdgeInsets.all(1) : EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                //Colors.pink.shade300,

                colorType == 'monochrome' ? Color(0xffA0D2E7) : btColor,

                colorType == 'monochrome' ? Color(0xff81B1D5) : btColor,

                colorType == 'monochrome' ? Color(0xff3D60A7) : btColor,

                colorType == 'monochrome' ? Color(0xff26408B) : btColor,

                btColor,
              ],
            ), //Vert Gradient// LinearGradient(colors: [Colors.red, Colors.black45]),
            borderRadius: BorderRadius.circular(35)),
        child: Container(
          width: 65,
          height: 150,
          alignment: Alignment.center,
          child: Text(
            '',
            //style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }

  Widget buildListElevatedButtonn(
      BuildContext ctx, Color btColor, String colorType) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(btColor),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 70.0, horizontal: 0.0)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          )),
      onPressed: () {
        Provider.of<ColorProvider>(ctx, listen: false)
            .colorsTypeChange(colorType);
        Provider.of<ColorProvider>(ctx, listen: false)
            .editRodomColor(colorType);
        Navigator.of(ctx).pushNamed(HomeScreen.routeName);
      },
      child: Text(''),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    String colorsType =
        Provider.of<ColorProvider>(context, listen: true).colors_palette_type;
    int nomberOfPalete = Provider.of<ColorProvider>(context, listen: true)
        .colors_palette_numbers;
    Widget positionedBTN(String direction, String icon, Function ontap) {
      return Positioned(
        //remove
        left: direction == 'left' ? dw / 4 - 35 : null,
        right: direction == 'right' ? dw / 4 - 35 : null,
        width: 35,
        height: 35,
        child: FloatingActionButton(
          child: Icon(
            icon == 'add' ? Icons.add : Icons.remove,
            size: 35.0,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          onPressed: () => {ontap()},
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 29),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              //color: Colors.amber,
              padding: EdgeInsets.only(right: 30),
              child: Text(
                'اختر عدد الالوان',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 25.0,
                    ),
              ),
            ),
            SizedBox(height: 40),
            Stack(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  //color: Colors.blue,
                ),
                Positioned(
                  child: Container(
                    width: dw / 4 - 17.5,
                    height: 35,
                    color: primaryColor.withOpacity(.35),
                  ),
                  right: 0,
                ),
                Positioned(
                  child: Container(
                    width: dw / 4 - 17.5,
                    height: 35,
                    color: primaryColor.withOpacity(.35),
                  ),
                  left: 0,
                ),
                positionedBTN(
                  'left',
                  'remove',
                  () {
                    if (nomberOfPalete > 3) {
                      nomberOfPalete = nomberOfPalete - 1;
                      Provider.of<ColorProvider>(context, listen: false)
                          .colorsNumbersChange(nomberOfPalete);
                    }
                  },
                ),

                //SizedBox(width: 50),
                Positioned(
                  left: dw / 2 - 7,
                  top: -10,
                  child: Text(
                    '${nomberOfPalete.toString()}',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 30.0,
                        ),
                  ),
                ),
                //SizedBox(width: 50),
                positionedBTN('right', 'add', () {
                  if (nomberOfPalete < 6) {
                    nomberOfPalete = nomberOfPalete + 1;
                    Provider.of<ColorProvider>(context, listen: false)
                        .colorsNumbersChange(nomberOfPalete);
                  }
                }),
              ],
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              //color: Colors.amber,
              padding: EdgeInsets.only(right: 30),
              child: Text(
                'اختر نمط الالوان',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 25.0,
                      // fontWeight: FontWeight.normal,
                    ),
              ),
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    //buildListElevatedButtonn(),
                    buildListElevatedButton(
                        context, Color(0xff2B2E4A), 'monochrome'),
                    SizedBox(height: 12),
                    Text(
                      'أحادى',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 22.0,
                            // fontWeight: FontWeight.normal,
                          ),
                    )
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    buildListElevatedButton(context, Color(0xff2B2E4A), 'dark'),
                    SizedBox(height: 12),
                    Text(
                      'داكن',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 23.0,
                            //fontWeight: FontWeight.normal,
                          ),
                    )
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    buildListElevatedButton(
                        context, Color(0xffE4FBFF), 'bright'),
                    SizedBox(height: 10),
                    Text(
                      'فاتح',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 25.0,
                            // fontWeight: FontWeight.normal,
                          ),
                    )
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    buildListElevatedButton(context, Color(0xff3EDBF0), 'cold'),
                    SizedBox(height: 10),
                    Text(
                      'بارد',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 25.0,
                            //fontWeight: FontWeight.normal,
                          ),
                    )
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    buildListElevatedButton(context, Color(0xffFA1E0E), 'warm'),
                    SizedBox(height: 10),
                    Text(
                      'حار',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 25.0,
                            //fontWeight: FontWeight.normal,
                          ),
                    )
                  ],
                ),
              ],
            ),

            // TextButton(
            //   child: Text("إنشاء الالوان"),
            //   onPressed: () async {
            //     await Provider.of<ColorProvider>(context, listen: false)
            //         .getColorType(colorsType);
            //     await Provider.of<ColorProvider>(context, listen: false)
            //         .editRodomColor(colorsType);

            //     //.pushReplacementNamed(HomeScreen.routeName);
            //   },
            //   style: ButtonStyle(
            //     padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            //         EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0)),
            //     backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
            //     foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
