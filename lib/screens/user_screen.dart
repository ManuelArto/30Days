import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:TrentaGiorni/providers/users_provider.dart';
import 'package:TrentaGiorni/models/user.dart';

class UserScreen extends StatefulWidget {
  static const routeName = "/userScreen";
  final int id;
  final DateTime selectedDate;

  UserScreen({this.id, this.selectedDate});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool newWeightCheck = false;
  DateTime selectedDate;
  TimeOfDay notificationTime;
  User user;
  Map<String, dynamic> _formData = {
    "name": null,
    "surname": null,
    "weight": null,
    "newWeight": null,
    "date": null,
    "waitTime": null,
    "notiticationTime": null
  };
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate;
    notificationTime = TimeOfDay(hour: 7, minute: 30);
    if (widget.id != null) {
      user = Provider.of<UsersProvider>(context, listen: false)
          .getUserById(widget.id);
      _formData["name"] = user.name;
      _formData["surname"] = user.surname;
      _formData["weight"] = user.weight;
      _formData["waitTime"] = user.nextDate.difference(user.date).inDays;
      selectedDate = user.date;
      notificationTime = user.notificationTime;
    }
  }

  Future<void> _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      picked = picked.subtract(Duration(
        hours: picked.hour,
        minutes: picked.minute,
        seconds: picked.second,
        milliseconds: picked.millisecond,
        microseconds: picked.microsecond,
      ));
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: notificationTime,
    );
    if (picked != null && picked != notificationTime) {
      setState(() {
        notificationTime = picked;
      });
    }
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    _formData["date"] = selectedDate;
    _formData["notificationTime"] = notificationTime;
    if (widget.id == null)
      Provider.of<UsersProvider>(context, listen: false).insertUser(_formData);
    else
      Provider.of<UsersProvider>(context, listen: false)
          .editUser(widget.id, _formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.person),
                title: TextFormField(
                  initialValue: _formData["name"],
                  decoration: InputDecoration(
                    labelText: "Nome",
                  ),
                  onSaved: (value) => _formData["name"] = value.trim(),
                  validator: (value) =>
                      value.isEmpty ? "Nome non puo' essere vuoto" : null,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.transparent),
                title: TextFormField(
                  initialValue: _formData["surname"],
                  decoration: InputDecoration(
                    labelText: "Cognome",
                  ),
                  onSaved: (value) => _formData["surname"] = value.trim(),
                  validator: (value) =>
                      value.isEmpty ? "Cognome non puo' essere vuoto" : null,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.transparent),
                title: TextFormField(
                  enabled: !newWeightCheck,
                  initialValue: _formData["weight"]?.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso",
                  ),
                  onSaved: (value) => _formData["weight"] = double.parse(value),
                  validator: (value) {
                    if (value.isEmpty) return "Peso non puo' essere vuoto";
                    double weight = double.tryParse(value);
                    if (weight == null) return "Inserire un peso corretto";
                    return null;
                  },
                ),
              ),
              if (widget.id != null)
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.transparent),
                  trailing: Checkbox(
                    value: newWeightCheck,
                    onChanged: (check) {
                      setState(() {
                        selectedDate = check ? user.nextDate : user.date;
                        newWeightCheck = check;
                      });
                    },
                  ),
                  title: TextFormField(
                    enabled: newWeightCheck,
                    initialValue: _formData['newWeight']?.toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Nuovo peso",
                    ),
                    onSaved: (value) => newWeightCheck
                        ? _formData['newWeight'] = double.parse(value ?? '0')
                        : _formData['newWeight'] = null,
                    validator: (value) {
                      if (!newWeightCheck) return null;
                      if (value.isEmpty) return "Peso non puo' essere vuoto";
                      double weight = double.tryParse(value);
                      if (weight == null) return "Inserire un peso corretto";
                      return null;
                    },
                  ),
                ),
              ListTile(
                leading: const Icon(Icons.access_time_sharp),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notificationTime.format(context)),
                    Divider(color: Colors.grey[900])
                  ],
                ),
                trailing: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  color: Colors.lightGreen[100],
                  onPressed: _selectTime,
                  child: Text('Seleziona ora\nnotifica',
                      textAlign: TextAlign.center),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.date_range),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat("dd/MM/yyy").format(selectedDate)),
                    Divider(color: Colors.grey[900])
                  ],
                ),
                trailing: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  color: Colors.lightGreen[100],
                  onPressed: _selectDate,
                  child: Text('Seleziona giorno\npesatura',
                      textAlign: TextAlign.center),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.more_time_outlined),
                title: TextFormField(
                  initialValue: _formData["waitTime"]?.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Fra quanti giorni vuoi ripesarlo?",
                  ),
                  onSaved: (value) => _formData["waitTime"] = int.parse(value),
                  validator: (value) {
                    if (value.isEmpty)
                      return "Numero di giorni non puo' essere vuoto";
                    int waitTime = int.tryParse(value);
                    if (waitTime == null)
                      return "Inserire un numero di giorni corretto";
                    DateTime prenotationDate = selectedDate.add(Duration(
                      days: waitTime,
                      hours: notificationTime.hour,
                      minutes: notificationTime.minute,
                    ));
                    if (prenotationDate.isBefore(DateTime.now()))
                      return "La prossima data deve essere nel futuro";
                    return null;
                  },
                ),
              ),
              if (widget.id != null)
                Container(
                  margin: const EdgeInsets.only(top: 30.0, left: 10.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    child: Text("Elimina utente"),
                    color: Colors.red[300],
                    onPressed: () async {
                      if (await buildShowDialog(context)) {
                        Provider.of<UsersProvider>(context, listen: false)
                            .removeUser(widget.id);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _submitForm(),
        child: Icon(Icons.save),
      ),
    );
  }

  Future<bool> buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Conferma"),
          content:
              const Text("Sei sicuro di volere cancellare questo elemento?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("ANNULLA"),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                "ELIMINA",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
