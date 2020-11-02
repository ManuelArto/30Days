import 'package:TrentaGiorni/models/user.dart';
import 'package:flutter/material.dart';

class UsersProvider with ChangeNotifier {
  List<User> _users = [
    User(
        id: UniqueKey().toString(),
        name: "Pippo",
        surname: "Arto",
        weight: 72,
        date: DateTime.parse("2020-04-04")),
    User(
        id: UniqueKey().toString(),
        name: "Mario",
        surname: "Rossi",
        weight: 78,
        date: DateTime.parse("2020-11-06")),
    User(
        id: UniqueKey().toString(),
        name: "Luigia",
        surname: "Pallavicini",
        weight: 56,
        date: DateTime.parse("2020-12-12")),
    User(
        id: UniqueKey().toString(),
        name: "Eren",
        surname: "Yeager",
        weight: 80,
        date: DateTime.parse("2020-04-23")),
    User(
        id: UniqueKey().toString(),
        name: "Giulia",
        surname: "Pasqualina",
        weight: 45,
        date: DateTime.parse("2020-01-02")),
    User(
        id: UniqueKey().toString(),
        name: "Pippo",
        surname: "Arto",
        weight: 72,
        date: DateTime.parse("2020-11-06")),
    User(
        id: UniqueKey().toString(),
        name: "Mario",
        surname: "Rossi",
        weight: 78,
        date: DateTime.parse("2020-05-02")),
    User(
        id: UniqueKey().toString(),
        name: "Luigia",
        surname: "Pallavicini",
        weight: 56,
        date: DateTime.parse("2020-04-10")),
    User(
        id: UniqueKey().toString(),
        name: "Giulia",
        surname: "Pasqualina",
        weight: 45,
        date: DateTime.parse("2020-05-04")),
    User(
        id: UniqueKey().toString(),
        name: "Dio",
        surname: "Arto",
        weight: 72,
        date: DateTime.parse("2020-04-07")),
    User(
        id: UniqueKey().toString(),
        name: "Mario",
        surname: "Rossi",
        weight: 78,
        date: DateTime.parse("2020-07-04")),
    User(
        id: UniqueKey().toString(),
        name: "Luigia",
        surname: "Pallavicini",
        weight: 56,
        date: DateTime.parse("2020-10-04")),
  ];

  get users => _users;

  void insertUser(Map data) {
    _users.add(User(
      id: UniqueKey().toString(),
      name: data['name'],
      surname: data['surname'],
      weight: data['weight'],
      date: data['date'],
    ));

    // sharedPreferences

    notifyListeners();
  }

  void removeUser(String id) {
    _users.removeWhere((user) => user.id == id);

    // sharedPreferences

    notifyListeners();
  }
}
