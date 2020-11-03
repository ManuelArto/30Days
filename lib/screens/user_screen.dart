import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:TrentaGiorni/providers/users_provider.dart';
import 'package:TrentaGiorni/models/user.dart';

class UserScreen extends StatefulWidget {
  static const routeName = "/userScreen";
  final User user;

  UserScreen(this.user);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  DateTime selectedDate = DateTime.now();
  Map<String, dynamic> _formData = {
    "name": null,
    "surname": null,
    "weight": null,
    "date": null,
  };
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    _formData["date"] = selectedDate;
    if (widget.user == null)
      Provider.of<UsersProvider>(context, listen: false).insertUser(_formData);
    else
      Provider.of<UsersProvider>(context, listen: false)
          .editUser(widget.user.id, _formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user != null) {
      _formData["name"] = widget.user.name;
      _formData["surname"] = widget.user.surname;
      _formData["weight"] = widget.user.weight;
      selectedDate = widget.user.date;
    }
    return Scaffold(
      appBar: AppBar(),
      body: Form(
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
              leading: const Icon(Icons.person, color: Colors.white),
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
              leading: const Icon(Icons.person, color: Colors.white),
              title: TextFormField(
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
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30.0, left: 10.0),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0)),
                child: Text("Delete user"),
                color: Colors.red[300],
                onPressed: () async {
                  if (await buildShowDialog(context)) {
                    Provider.of<UsersProvider>(context, listen: false)
                        .removeUser(widget.user.id);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
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
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  "ELIMINA",
                  style: TextStyle(color: Colors.red),
                )),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("ANNULLA"),
            ),
          ],
        );
      },
    );
  }
}
