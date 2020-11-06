import 'package:TrentaGiorni/widgets/user_calendar.dart';
import 'package:TrentaGiorni/widgets/user_lists.dart';
import 'package:flutter/material.dart';

class UsersController extends StatefulWidget {
  @override
  _UsersControllerState createState() => _UsersControllerState();

  final Size screenSize;
  final Function selectDate;

  UsersController(this.screenSize, this.selectDate);
}

class _UsersControllerState extends State<UsersController>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => widget.selectDate(DateTime.now()));
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: widget.screenSize.height * 0.12,
          width: widget.screenSize.width,
          child: TabBar(
            tabs: [
              Tab(text: "Lista Utenti", icon: Icon(Icons.list)),
              Tab(text: "Calendario Prenotazioni", icon: Icon(Icons.calendar_today)),
            ],
            controller: _tabController,
          ),
        ),
        SizedBox(height: widget.screenSize.height * 0.01),
        Container(
          height: widget.screenSize.height * 0.7,
          width: widget.screenSize.width,
          child: TabBarView(
            children: [
              UserLists(widget.screenSize),
              UserCalendar(widget.selectDate),
            ],
            controller: _tabController,
          ),
        ),
      ],
    );
  }
}
