import 'package:TrentaGiorni/screens/active_notifications_screen.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '30 Days',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            decoration: BoxDecoration(
              color: Colors.green[400],
            ),
          ),
          ListTile(
            title: Text('Active Notifications'),
            onTap: () async {
              await Navigator.of(context)
                  .pushNamed(ActiveNotificationsScreen.routeName);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Infos'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
