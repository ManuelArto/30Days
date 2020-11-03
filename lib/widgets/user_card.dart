import 'package:TrentaGiorni/providers/users_provider.dart';
import 'package:TrentaGiorni/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:TrentaGiorni/models/user.dart';
import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    @required this.usersLength,
    @required this.index,
    @required this.user,
  });

  final int index, usersLength;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
          top: 0,
          left: 10.0,
          right: 10.0,
          bottom: index + 1 == usersLength ? 100.0 : 7.0),
      elevation: 4,
      shadowColor: Colors.green[300],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.grey[300])),
      child: ListTile(
        title: Text(
          "${user.surname} ${user.name}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
        subtitle: Text(
            "Peso: ${user.weight}Kg \t\t In data: ${DateFormat('dd/MM/yyyy').format(user.date)}"),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          color: Colors.teal[300],
          onPressed: () => Navigator.of(context)
              .pushNamed(UserScreen.routeName, arguments: user),
        ),
      ),
    );
  }
}
