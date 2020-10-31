import 'package:flutter/material.dart';

import 'screens/edit_screen.dart';
import 'screens/home_screen.dart';
import 'screens/insert_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '30 Days',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.orangeAccent,
      ),
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomeScreen.routeName:
            return MaterialPageRoute(builder: (context) => HomeScreen());
          case EditScreen.routeName:
            return MaterialPageRoute(builder: (context) => EditScreen());
          case InsertScreen.routeName:
            return MaterialPageRoute(builder: (context) => InsertScreen());
        }
      },
    );
  }
}
