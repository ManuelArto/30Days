import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:TrentaGiorni/models/user.dart';
import 'package:TrentaGiorni/helpers/notification_helper.dart'
    as NotificationHelper;
import 'package:shared_preferences/shared_preferences.dart';

class UsersProvider with ChangeNotifier {
  static final random = Random();
  List<User> _users = [];

  get users => List<User>.from(_users);

  UsersProvider(
      Function onNotificationInLowerVersions, Function onNotificationClick) {
    NotificationHelper.init();
    NotificationHelper.setListenerForLowerVersions(
        onNotificationInLowerVersions);
    NotificationHelper.setOnNotificationClick(onNotificationClick);
    getUsers();
  }

  void getUsers() async {
      final prefs = await SharedPreferences.getInstance();
      Set<String> keys = prefs.getKeys();
      print("keys: $keys");
      keys.forEach((key) {
        Map<String, dynamic> jsonData = json.decode(prefs.getString(key));
        print(jsonData);
        _users.add(User.fromJson(jsonData));
      });
  }

  void insertUser(Map data) async {
    User user = User(
      id: random.nextInt(pow(2, 31) - 1),
      name: data['name'],
      surname: data['surname'],
      weight: data['weight'],
      date: data['date'],
    );
    _users.add(user);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(user.id.toString(), json.encode(user.toJson()));

    // NotificationHelper.scheduleNotification(user);

    notifyListeners();
  }

  void editUser(int id, Map data) async {
    User user = _users.firstWhere((user) => user.id == id);
    // if (user.date != data["date"])
    // NotificationHelper.scheduleNotification(user);
    user.update(data);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(user.id.toString(), json.encode(user.toJson()));

    notifyListeners();
  }

  void removeUser(int id) async {
    _users.removeWhere((user) => user.id == id);
    // NotificationHelper.deleteNotification(id);

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(id.toString());

    notifyListeners();
  }
}
