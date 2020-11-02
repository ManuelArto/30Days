
import 'package:flutter/material.dart';

class User {

  String id, name, surname;
  double weight;
  DateTime date;

  User({@required this.id, @required this.name, @required this.surname, @required this.weight, @required this.date});

  // User.fromJson(String jsonData);
}