import 'package:flutter/material.dart';

import 'ui/beer_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: Colors.white),
            textTheme: Theme.of(context).primaryTextTheme.apply(bodyColor: Colors.white)),
        primaryColor: Color.fromARGB(255, 0, 175, 219),
        primaryColorDark: Color.fromARGB(255, 15, 114, 163),
        accentColor: Color.fromARGB(255, 246, 102, 107),
      ),
      home: Scaffold(
        body: BeerList(),
      ),
    );
  }
}
