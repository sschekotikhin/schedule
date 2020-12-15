import 'package:flutter/material.dart';
import 'package:schedule/src/resources/variables.dart';

class ScheduleBottomNavBar extends StatefulWidget {
  final int _tabIndex;

  ScheduleBottomNavBar(this._tabIndex);

  @override
  createState() => new ScheduleBottomNavBarState(_tabIndex);
}

class ScheduleBottomNavBarState extends State<ScheduleBottomNavBar> {
  int _currentTabIndex = 0;
  String _weekDays;

  ScheduleBottomNavBarState(this._currentTabIndex) {
    bottomNavBarState = this;
  }

  @override
  Widget build(BuildContext context) {
    _currentTabIndex = scheduleMode;
    _weekDays = '${firstDay.day.toString()}.${firstDay.month.toString().padLeft(2, '0')} - ${firstDay.add(Duration(days: 6)).day.toString()}.${firstDay.add(Duration(days: 6)).month.toString().padLeft(2, '0')}';
    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(color: Theme.of(context).primaryIconTheme.color, icon: Icon(Icons.arrow_back), tooltip: 'Назад', onPressed: savedScheduleMode ? null : (){
            daysTabBarState.setState(() {
              firstDay = firstDay.subtract(new Duration(days: 7));
            });
            this.setState((){});
            tabBarViewState.setState((){});
          }),
          Text(_weekDays, style: TextStyle(color: Theme.of(context).primaryIconTheme.color)),
          IconButton(color: Theme.of(context).primaryIconTheme.color, icon: Icon(Icons.arrow_forward), tooltip: 'Вперед', onPressed: savedScheduleMode ? null : (){
            daysTabBarState.setState(() {
              firstDay = firstDay.add(new Duration(days: 7));
            });
            this.setState((){});
            tabBarViewState.setState((){});
          }),
        ]
      )
    );
  }
}