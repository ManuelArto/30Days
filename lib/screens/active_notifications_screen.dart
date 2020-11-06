import 'package:TrentaGiorni/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActiveNotificationsScreen extends StatelessWidget {
  static const routeName = "/ActiveNotificationScreen";

  UsersProvider usersProvider;
  List activeNotifications, pendingNotifications;

  void retrieveNotifications() async {
    activeNotifications = await usersProvider.getActiveNotifications();
    pendingNotifications = await usersProvider.getPendingNotifications();
  }

  @override
  Widget build(BuildContext context) {
    usersProvider = Provider.of<UsersProvider>(context, listen: false);
    retrieveNotifications();
    return Scaffold(
      body: Center(child: Text("Notifications")),
    );
  }
}
