import 'package:flutter/material.dart';

class FavoritesColorsScreen extends StatelessWidget {
  static const routeName = '/Favorites_Colors_Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites Colors Screen'),
      ),
      body: Center(
        child: Text(
          'Favorites Colors page',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
