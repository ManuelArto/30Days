import 'package:flutter/material.dart';

class User {
  int id;
  String name, surname;
  double weight;
  DateTime date, nextDate;
  TimeOfDay notificationTime;

  User(
      {@required this.id,
      @required this.name,
      @required this.surname,
      @required this.weight,
      @required this.date,
      @required this.notificationTime,
      int waitTime}) {
    nextDate = date.add(Duration(days: waitTime));
    nextDate = nextDate.subtract(Duration(
      hours: nextDate.hour,
      minutes: nextDate.minute,
      seconds: nextDate.second,
    ));
  }

  User.fromJson(Map<String, dynamic> jsonData)
      : id = jsonData["id"],
        name = jsonData["name"],
        surname = jsonData["surname"],
        weight = jsonData["weight"],
        date = DateTime.parse(jsonData["date"]),
        nextDate = DateTime.parse(jsonData["nextDate"]),
        notificationTime = TimeOfDay(
          hour: jsonData['notificationTimeHours'],
          minute: jsonData["notificationTimeMinutes"],
        );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "weight": weight,
        "date": date.toIso8601String(),
        "nextDate": nextDate.toIso8601String(),
        "notificationTimeHours": notificationTime.hour,
        "noiticationTimeMinutes": notificationTime.minute,
      };

  void update(Map data) {
    name = data["name"];
    surname = data["surname"];
    weight = data["weight"];
    date = data["date"];
    notificationTime = data["notificationTime"];
    nextDate = date.add(Duration(days: data["waitTime"]));
    nextDate = nextDate.subtract(Duration(
        hours: nextDate.hour,
        minutes: nextDate.minute,
        seconds: nextDate.second));
  }
}
