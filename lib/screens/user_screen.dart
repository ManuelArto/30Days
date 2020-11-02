import 'package:TrentaGiorni/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  static const routeName = "/userScreen";
  final String id;

  UserScreen(this.id);

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
    Provider.of<UsersProvider>(context, listen: false).insertUser(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.person),
              title: TextFormField(
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
                color: Colors.lightGreen[100],
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
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
}
