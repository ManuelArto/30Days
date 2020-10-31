
class User {
  
  String name, surname;
  double weight;
  DateTime date;

  User({this.name, this.surname, this.weight, this.date});

}

List<User> users = [
  User(name: "Pippo", surname: "Arto", weight: 72, date: DateTime.parse("2020-04-04")),
  User(name: "Mario", surname: "Rossi", weight: 78, date: DateTime.parse("2020-11-06")),
  User(name: "Luigia", surname: "Pallavicini", weight: 56, date: DateTime.parse("2020-12-12")),
  User(name: "Eren", surname: "Yeager", weight: 80, date: DateTime.parse("2020-04-23")),
  User(name: "Giulia", surname: "Pasqualina", weight: 45, date: DateTime.parse("2020-01-02")),
  User(name: "Pippo", surname: "Arto", weight: 72, date: DateTime.parse("2020-11-06")),
  User(name: "Mario", surname: "Rossi", weight: 78, date: DateTime.parse("2020-05-02")),
  User(name: "Luigia", surname: "Pallavicini", weight: 56, date: DateTime.parse("2020-04-10")),
  User(name: "Giulia", surname: "Pasqualina", weight: 45, date: DateTime.parse("2020-05-04")),
  User(name: "d", surname: "Arto", weight: 72, date: DateTime.parse("2020-04-07")),
  User(name: "Mario", surname: "Rossi", weight: 78, date: DateTime.parse("2020-07-04")),
  User(name: "Luigia", surname: "Pallavicini", weight: 56, date: DateTime.parse("2020-10-04")),
];