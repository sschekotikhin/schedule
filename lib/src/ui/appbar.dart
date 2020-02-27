import 'package:flutter/material.dart';
import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/schedule_selector_button.dart';

AppBar ScheduleAppBar() {
  return new AppBar(
      title: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new ScheduleSelectorButton(scheduleMode)
          )
        ]
      ),
      actions: <Widget>[
        new IconButton(icon: new Icon(Icons.calendar_today), onPressed: () {})
      ]
    );
}
