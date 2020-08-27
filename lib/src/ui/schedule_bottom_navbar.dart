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
          IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryIconTheme.color), onPressed: (){
            daysTabBarState.setState(() {
              firstDay = firstDay.subtract(new Duration(days: 7));
              //daysTabBarState.tabController.animateTo(0);
            });
            this.setState((){});
            tabBarViewState.setState((){});
          }),
          Text(_weekDays, style: TextStyle(color: Theme.of(context).primaryIconTheme.color)),
          IconButton(icon: Icon(Icons.arrow_forward, color: Theme.of(context).primaryIconTheme.color), onPressed: (){
            daysTabBarState.setState(() {
              firstDay = firstDay.add(new Duration(days: 7));
            });
            this.setState((){});
            tabBarViewState.setState((){});
          }),
        ]
      )
    );
    // return new SizedBox( 
    //   height: 58,
    //   child: DefaultTabController(
    //     length: 2,
    //     child: TabBarView(children: <Widget>[ 
    //       BottomNavigationBar(
    //         items: [
    //           BottomNavigationBarItem(icon: Icon(Icons.work), title: Text('Преподаватель')),
    //           BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('Студент')),
    //           BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Аудитория'))
    //         ],
    //         currentIndex: _currentTabIndex,
    //         type: BottomNavigationBarType.fixed,
    //         onTap: (int tabIndex) {
    //           setState(() {
    //             _currentTabIndex = scheduleMode = tabIndex;

    //             tabBarViewState.setState(() {});

    //             scheduleSelectorState.setState(() {
    //               scheduleSelectorState.tabIndex = tabIndex;
    //               scheduleSelectorState.stateIndex = lastSelectorStates[tabIndex];
    //             });

    //             selectorButtonState.setState(() {
    //               selectorButtonState.tabIndex = tabIndex;
    //             });

    //             prefs.setInt('schedule_mode', tabIndex);
    //           });
    //         },
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
    //             daysTabBarState.setState(() {
    //               firstDay = firstDay.subtract(new Duration(days: 7));
    //               //daysTabBarState.tabController.animateTo(0);
    //             });
    //             this.setState((){});
    //             tabBarViewState.setState((){});
    //           }),
    //           Text(_weekDays),
    //           IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){
    //             daysTabBarState.setState(() {
    //               firstDay = firstDay.add(new Duration(days: 7));
    //             });
    //             this.setState((){});
    //             tabBarViewState.setState((){});
    //           }),
    //         ]
    //       )
    //     ]
    //   )
    // ));
  }
}