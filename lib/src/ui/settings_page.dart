import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:schedule/src/ui/drawer.dart';

import 'package:schedule/src/resources/variables.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => new SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool _hideEmpty;

  bool get getHideEmpty => _hideEmpty;

  void _hideEmptyChanged(bool value) => setState(() {
    _hideEmpty = value;
    prefs.setBool('setting_hideEmpty', value);
  });

  @override
  void initState() {
    super.initState();
    //set values
    _hideEmpty = prefs.getBool('setting_hideEmpty') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Настройки'),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context);})
        ),
        
        //drawer: ScheduleDrawer(),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Скрывать пустые занятия', style: TextStyle(fontSize: 16)), 
                    Switch(value: _hideEmpty, onChanged: _hideEmptyChanged)
                  ]
                ),
                Divider(thickness: 1.5)
              ]
            )
          )
        )
      ),
    );
  }
}