import 'package:flutter/material.dart';

import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/schedule_selector_button.dart';

import 'package:schedule/src/ui/exams_schedule/exams_tab_view.dart';

class ExamsAppBar extends StatefulWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(100.0);

  ExamsAppBarState createState() => ExamsAppBarState();
}

class ExamsAppBarState extends State<ExamsAppBar> {
  @override
  Widget build(BuildContext context) {
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
        new IconButton(icon: new Icon(null), onPressed: null)
      ],
      bottom: ExamsTabBar()
    );
  }
}