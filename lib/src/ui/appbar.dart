import 'package:flutter/material.dart';

AppBar ScheduleAppBar() {
  return new AppBar(
      title: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new FlatButton(
              onPressed: () {}, 
              child: new Text('ИПАИТ, 3 курс, 71ПГ'), 
              textColor: Colors.white
            )
          )
        ]
      ),
      actions: <Widget>[
        new IconButton(icon: new Icon(Icons.calendar_today), onPressed: () {})
      ]
    );
}