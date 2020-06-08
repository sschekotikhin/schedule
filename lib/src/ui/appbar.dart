import 'package:flutter/material.dart';
import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/daysTabBar.dart';
import 'package:schedule/src/ui/schedule_selector_button.dart';

class ScheduleAppBar extends StatefulWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(100.0);

  ScheduleAppBarState createState() => ScheduleAppBarState();
}

class ScheduleAppBarState extends State<ScheduleAppBar> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new AppBar(
      bottom: DaysTabBar(tabController),
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
              firstDay = day.subtract(new Duration(
                days: day.weekday - 1,
                hours: day.hour,
                minutes: day.minute,
                seconds: day.second,
                milliseconds: day.millisecond,
                microseconds: day.microsecond
              ));
              firstDay = firstDay.add(new Duration(hours: 3));
              tabBarViewState.setState((){});
              bottomNavBarState.setState(() { });
              // daysTabBarState.tabController.animateTo(day.weekday - 1 - (day.weekday == 7 ? 1 : 0), curve: Curves.ease, duration: Duration(milliseconds: 250));
              tabController.animateTo(day.weekday - 1 - (day.weekday == 7 ? 1 : 0), curve: Curves.ease, duration: Duration(milliseconds: 250));
            });
          });        
        })
      ]
    );
  }
}
