import 'package:TrentaGiorni/screens/user_screen.dart';
import 'package:TrentaGiorni/widgets/drawer_widget.dart';
import 'package:TrentaGiorni/widgets/users_controller.dart';
import 'package:flutter/material.dart';

import 'package:TrentaGiorni/widgets/gradient_background.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homescreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    selectedDate = now.subtract(Duration(
      hours: now.hour,
      minutes: now.minute,
      seconds: now.second,
    ));
  }

  void selectDate(DateTime selectedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(),
        body: Stack(
          children: [
            GradienBackGround(height: screenSize.height * 0.35),
            Positioned(
              top: screenSize.height * 0.01,
              child: IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () => _scaffoldKey.currentState.openDrawer()),
            ),
            Positioned(
              top: screenSize.height * 0.05,
              width: screenSize.width,
              child: Text(
                "30 Days",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber[50],
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: screenSize.height * 0.15,
              child: UsersController(screenSize, selectDate),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushNamed(UserScreen.routeName,
                arguments: {"id": null, "selectedDate": selectedDate});
          },
        ),
      ),
    );
  }
}
