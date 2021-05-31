import '../providers/color_provider.dart';
import 'package:provider/provider.dart';

import './screens/color_palette_settings_screen.dart';
import './screens/favorites_colors_screen.dart';
import './screens/home_screen.dart';
import './screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ColorProvider>(
          create: (ctx) => ColorProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  int nomberOfPalete = 5;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'palette Demo',
      theme: ThemeData(
        primarySwatch: Provider.of<ColorProvider>(context, listen: false)
            .setMaterialColor(Color(0xff481C49).hashCode),
        fontFamily: 'Cairo',
        textTheme: Theme.of(context).textTheme.copyWith(
            bodyText1: TextStyle(
              fontFamily: 'Cairo',
            ),
            headline6: TextStyle(
              color: Provider.of<ColorProvider>(context, listen: false)
                  .setMaterialColor(Color(0xff481C49).hashCode),
              fontSize: 40,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            )),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => WelcomeScreen(),
        ColorPaletteSettingsScreen.routeName: (ctx) =>
            ColorPaletteSettingsScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        FavoritesColorsScreen.routeName: (ctx) => FavoritesColorsScreen(),
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
