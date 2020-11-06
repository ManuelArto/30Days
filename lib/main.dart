import 'dart:convert';

import 'package:TrentaGiorni/providers/users_provider.dart';
import 'package:TrentaGiorni/screens/active_notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'models/received_notification.dart';
import 'screens/home_screen.dart';
import 'screens/user_screen.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider(
      create: (context) =>
          UsersProvider(onNotificationInLowerVersions, onNotificationClick),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '30 Days',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.orangeAccent,
        ),
        home: HomeScreen(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case HomeScreen.routeName:
              return MaterialPageRoute(builder: (context) => HomeScreen());
            case UserScreen.routeName:
              return MaterialPageRoute(
                  builder: (context) => UserScreen(
                        id: (settings.arguments as Map)["id"],
                        selectedDate:
                            (settings.arguments as Map)["selectedDate"],
                      ));
            case ActiveNotificationsScreen.routeName:
              return MaterialPageRoute(
                  builder: (context) => ActiveNotificationsScreen());
          }
        },
      ),
    );
  }

  void onNotificationInLowerVersions(
      ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  Future onNotificationClick(String payload) async{
    Map<String, dynamic> payloadData = json.decode(payload);
    print('Payload $payloadData');
    // CONTEXT ERROR 
    // await Navigator.of(context).pushNamed(UserScreen.routeName, arguments: {
    //   "id": payloadData['id'],
    //   "selectedDate": DateTime.parse(payloadData["selectedDate"])
    // });
  }
}
