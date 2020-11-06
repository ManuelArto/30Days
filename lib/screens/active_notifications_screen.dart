import 'package:TrentaGiorni/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActiveNotificationsScreen extends StatelessWidget {
  static const routeName = "/ActiveNotificationScreen";

  UsersProvider usersProvider;
  List activeNotifications, pendingNotifications;

  Future<void> retrieveNotifications() async {
    activeNotifications = await usersProvider.getActiveNotifications();
    pendingNotifications = await usersProvider.getPendingNotifications();
  }

  @override
  Widget build(BuildContext context) {
    usersProvider = Provider.of<UsersProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: retrieveNotifications(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: pendingNotifications.length,
                    itemBuilder: (context, index) {
                      final notification = pendingNotifications[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 5.0),
                        child: ListTile(
                          tileColor: Colors.red[100],
                          title: Text(notification.payload),
                          trailing: Text(index.toString()),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
