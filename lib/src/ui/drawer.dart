import 'package:flutter/material.dart';
import 'package:schedule/src/resources/variables.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:schedule/src/app.dart';
import 'package:schedule/src/ui/settings_page.dart';
import 'package:schedule/src/ui/exams_schedule/exams_schedule_page.dart';
import 'package:schedule/src/ui/lessons_schedule_page.dart';

class ScheduleDrawer extends StatelessWidget {
  _launchURL() async {
    const String url = 'http://oreluniver.ru';
    if (await canLaunch(url)){
      await launch(url);
    }
  }

  @override
  Widget build (BuildContext context) {
    return new Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column (
              // padding: EdgeInsets.zero,
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
                ),
              ]
            )
          ),
          // Divider(height: 1,),
          // Padding(
          //   padding: EdgeInsets.all(16),
          //   child: Text('data'),
          // ),
          Container(
            // padding: EdgeInsets.only(bottom: 16),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Divider(),
                // Text(
                //   'Информация о расписании получена с сайта ОГУ им И.С. Тургенева',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(fontSize: 12),
                // ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    child: Column(
                      children: [
                        Text(
                          'Информация о расписании получена с сайта ОГУ имени И.С. Тургенева',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Text(
                          'oreluniver.ru',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            // color: primaryColor
                          ),
                        )),
                      ]
                    ),
                    onTap: (){
                      _launchURL();
                    },
                  )
                )
              ],
            )
          )
        ]
      )
    );
  }
}