import 'package:flutter/material.dart';
import 'package:schedule/src/app.dart';
import 'package:schedule/src/ui/settings_page.dart';
import 'package:schedule/src/ui/exams_schedule/exams_schedule_page.dart';
import 'package:schedule/src/ui/lessons_schedule_page.dart';

class ScheduleDrawer extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Image.asset('assets/images/logo_transparent_no_paddings_2.png')),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Расписание ОГУ')
                  )
                ]
              
            ),
            // decoration: BoxDecoration(),
          ),
          ListTile(
            title: Text('Расписание занятий'),
            leading: Icon(Icons.schedule),
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => LessonsSchedulePage()));
            }
          ),
          ListTile(
            title: Text('Расписание экзаменов'),
            leading: Icon(Icons.book),
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ExamsSchedulePage()));
            }
          ),
          ListTile(
            title: Text('Настройки'),
            leading: Icon(Icons.settings),
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            }
          )
        ]
      )
    );
  }
}