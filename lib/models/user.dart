import 'package:flutter/material.dart';

class User {
  int id;
  String name, surname;
  double weight;
  DateTime date, nextDate;

  User(
      {@required this.id,
      @required this.name,
      @required this.surname,
      @required this.weight,
      @required this.date}) {
    nextDate = date.add(Duration(days: 30));
    nextDate = nextDate.subtract(Duration(
        hours: nextDate.hour,
        minutes: nextDate.minute,
        seconds: nextDate.second));
  }

  User.fromJson(Map<String, dynamic> jsonData)
      : id = jsonData["id"],
        name = jsonData["name"],
        surname = jsonData["surname"],
        weight = jsonData["weight"],
        date = DateTime.parse(jsonData["date"]),
        nextDate = DateTime.parse(jsonData["nextDate"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "weight": weight,
        "date": date.toIso8601String(),
        "nextDate": nextDate.toIso8601String(),
      };

  void update(Map data) {
    name = data["name"];
    surname = data["surname"];
    weight = data["weight"];
    date = data["date"];
    nextDate = date.add(Duration(days: 30));
    nextDate = nextDate.subtract(Duration(
        hours: nextDate.hour,
        minutes: nextDate.minute,
        seconds: nextDate.second));
  }
}
