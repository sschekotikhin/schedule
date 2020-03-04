import 'package:flutter/material.dart';
import 'package:schedule/src/resources/functions.dart';
import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/schedule_selector.dart';

class ScheduleBottomNavBar extends StatefulWidget {
  final int _tabIndex;

  ScheduleBottomNavBar(this._tabIndex);

  @override
  createState() => new ScheduleBottomNavBarState(_tabIndex);
}

class ScheduleBottomNavBarState extends State<ScheduleBottomNavBar> {
  int _currentTabIndex = 0;

  ScheduleBottomNavBarState(this._currentTabIndex) {
    bottomNavBarState = this;
  }

  @override
  Widget build(BuildContext context) {
    _currentTabIndex = scheduleMode;
    return new SizedBox( 
      height: 58,
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.work), title: Text('Преподаватель')),
          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('Студент')),
          BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Аудитория'))
        ],
        currentIndex: _currentTabIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int tabIndex) {
          setState(() {
            _currentTabIndex = scheduleMode = tabIndex;

            tabBarViewState.setState(() {});

            scheduleSelectorState.setState(() {
              scheduleSelectorState.tabIndex = tabIndex;
              scheduleSelectorState.stateIndex = lastSelectorStates[tabIndex];
            });

            selectorButtonState.setState(() {
              selectorButtonState.tabIndex = tabIndex;
            });

            prefs.setInt('schedule_mode', tabIndex);
          });
        },
      )
    );
  }
}