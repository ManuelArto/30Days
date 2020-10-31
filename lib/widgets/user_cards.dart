import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:TrentaGiorni/models/user.dart';

class UserCards extends StatelessWidget {
  final Size screenSize;
  final String _queryUser;

  UserCards(this._queryUser, this.screenSize);

  @override
  Widget build(BuildContext context) {
    if (users.length == 0)
      return Expanded(
        child: Center(
          child: Text(
            "Add a new user",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      );
    final List<User> _users = _queryUser == ""
        ? users
        : users
            .where((element) =>
                element.name
                    .toUpperCase()
                    .startsWith(_queryUser.toUpperCase()) ||
                element.surname
                    .toUpperCase()
                    .startsWith(_queryUser.toUpperCase()))
            .toList();
    _users.sort((user1, user2) => user1.date.difference(user2.date).inSeconds);
    return Flexible(
      fit: FlexFit.tight,
      child: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          User user = _users[index];
          return Card(
            margin: EdgeInsets.only(
                top: 0,
                left: 10.0,
                right: 10.0,
                bottom: index + 1 == users.length ? 100.0 : 7.0),
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
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
