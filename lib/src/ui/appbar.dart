import 'package:flutter/material.dart';
import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/schedule_selector_button.dart';

class ScheduleAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => new Size.fromHeight(50.0);

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
        new IconButton(icon: new Icon(Icons.calendar_today), onPressed: () {
          showDatePicker(
            context: context,
            locale: Locale('ru'), 
            initialDate: DateTime.now(), 
            firstDate: DateTime(DateTime.now().year - 1), 
            lastDate: DateTime(DateTime.now().year + 1)
          ).then((DateTime day) {
            daysTabBarState.setState(() {
              firstDay = day.subtract(new Duration(days: day.weekday));
              daysTabBarState.tabController.animateTo(day.weekday - 1, curve: Curves.ease, duration: Duration(milliseconds: 250));
            });
          });        
        })
      ]
    );
  }
}
