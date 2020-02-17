import 'package:flutter/material.dart';

class ScheduleDrawer extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Расписание ОГУ'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text('Расписание'),
            leading: Icon(Icons.access_time),
            onTap: () {
              Navigator.pop(context);
            }
          ),
          ListTile(
            title: Text('Настройки'),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
            }
          )
        ]
      )
    );
  }
}