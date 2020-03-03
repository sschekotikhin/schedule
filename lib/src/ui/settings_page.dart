import 'package:flutter/material.dart';
import 'package:schedule/src/ui/drawer.dart';

import 'package:schedule/src/resources/variables.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => new SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool _autosave, _hideEmpty;

  bool get autosave => _autosave;
  bool get hideEmpty => _hideEmpty;

  void _autosaveChanged(bool value) => setState((){
    _autosave = value;
    prefs.setBool('setting_autosave', value);
  });

  void _hideEmptyChanged(bool value) => setState(() {
    _hideEmpty = value;
    prefs.setBool('setting_hideEmpty', value);
  });

  @override
  void initState() {
    super.initState();
    //set values
    _autosave = prefs.getBool('setting_autosave');
    _hideEmpty = prefs.getBool('setting_hideEmpty');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Настройки'),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context);})
        ),
        
        //drawer: ScheduleDrawer(),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Сохранение расписания в памяти устройста'), 
                    Switch(value: _autosave, onChanged: _autosaveChanged)
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Скрыть пустые занятия'), 
                    Switch(value: _hideEmpty, onChanged: _hideEmptyChanged)
                  ]
                )
              ]
            )
          )
        )
      ),
    );
  }
}