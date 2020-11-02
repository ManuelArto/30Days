import 'package:TrentaGiorni/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/notification_helper.dart' as NotificationHelper;
import 'models/received_notification.dart';
import 'screens/home_screen.dart';
import 'screens/user_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    initNotification();
    return ChangeNotifierProvider(
      create: (context) => UsersProvider(),
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
                  builder: (context) => UserScreen(settings.arguments));
          }
        },
      ),
    );
  }

  void initNotification() {
    NotificationHelper.init();
    NotificationHelper.setListenerForLowerVersions(
        onNotificationInLowerVersions);
    NotificationHelper.setOnNotificationClick(onNotificationClick);
  }

  void onNotificationInLowerVersions(
      ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  void onNotificationClick(String payload) {
    print('Payload $payload');
    // Navigator.of(context).pushNamed(UserScreen.routeName, arguments: pa)
  }
}
