import 'package:TrentaGiorni/models/user.dart';
import 'package:TrentaGiorni/providers/users_provider.dart';
import 'package:TrentaGiorni/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCards extends StatelessWidget {
  final Size screenSize;
  final String _queryUser;

  UserCards(this._queryUser, this.screenSize);

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final List<User> users = usersProvider.users;
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
    _users.sort((user1, user2) => user1.nextDate.difference(user2.nextDate).inSeconds);
    return Flexible(
      fit: FlexFit.tight,
      child: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          User user = _users[index];
          return UserCard(usersLength: users.length, index: index, user: user);
        },
      ),
    );
  }
}
