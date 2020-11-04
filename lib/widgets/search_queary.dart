import 'package:flutter/material.dart';

class SearchQuery extends StatelessWidget {
  final Function setQueryUser;
  final FocusNode _focusNode = FocusNode();
  
  SearchQuery(this.setQueryUser);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 4.0),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5,
      child: TextField(
        focusNode: _focusNode,
        autofocus: false,
        onChanged: (value) => setQueryUser(value),
        showCursor: false,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          hintText: "Search Users",
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0),
          ),
        ),
      ),
    );
  }
}
