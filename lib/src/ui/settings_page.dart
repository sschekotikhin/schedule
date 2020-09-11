import 'package:flutter/material.dart';

import 'package:schedule/src/resources/variables.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => new SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool _hideEmpty;
  bool _showNextDay;
  String _nextDayTime;

  bool get getHideEmpty => _hideEmpty;

  void _hideEmptyChanged(bool value) => setState(() {
    _hideEmpty = value;
    prefs.setBool('setting_hide_empty', value);
  });

  void _showNextDayChanged(bool value) => setState(() {
    _showNextDay = value;
    prefs.setBool('setting_show_next_day', value);
    prefs.setString('setting_next_day_time', _nextDayTime);
  });


  @override
  void initState() {
    super.initState();
    //set values
    _hideEmpty = prefs.getBool('setting_hide_empty') ?? false;
    _showNextDay = prefs.getBool('setting_show_next_day') ?? false;
    _nextDayTime = prefs.getString('setting_next_day_time') ?? '21:00';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Expanded(child: Text('Скрывать пустые занятия', style: TextStyle(fontSize: 16))), 
                  Switch(value: _hideEmpty, onChanged: _hideEmptyChanged)
                ]
              ),
              Divider(thickness: 1.5),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Text('Автоматически показывать следующий день', style: TextStyle(fontSize: 16))), 
                  Switch(value: _showNextDay, onChanged: _showNextDayChanged)
                ]
              ),
              !_showNextDay ? Container() : Row( mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('После: ', style: TextStyle(fontSize: 16)),
                  OutlineButton(
                    child: Text(_nextDayTime, style: TextStyle(fontSize: 14)),
                    onPressed: () {
                      TimeOfDay time = TimeOfDay(
                        hour: int.parse(_nextDayTime.split(':')[0]), 
                        minute: int.parse(_nextDayTime.split(':')[1])
                      );
                      showTimePicker(
                        context: context, 
                        initialTime: TimeOfDay(hour: time.hour, minute: time.minute)
                      ).then((TimeOfDay value) {
                        setState(() {
                          _nextDayTime = value.format(context);
                        prefs.setString('setting_next_day_time', _nextDayTime);
                        });
                      });
                    }
                  )
                ]
              ),
              Divider(thickness: 1.5)
            ]
          )
        )
      )
    );
  }
}