import 'package:TrentaGiorni/widgets/search_queary.dart';
import 'package:TrentaGiorni/widgets/user_cards.dart';
import 'package:flutter/material.dart';

class UserLists extends StatefulWidget {
  @override
  _UserListsState createState() => _UserListsState();

  final Size screenSize;

  UserLists(this.screenSize);
}

class _UserListsState extends State<UserLists> {
  String _queryUser = "";

  void setQueryUser(String query) {
    setState(() => _queryUser = query);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchQuery(setQueryUser),
        UserCards(_queryUser, widget.screenSize),
      ],
    );
  }
}