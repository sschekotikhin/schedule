import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/src/blocs/bloc.dart';
import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/lessons_list_view.dart';
import 'package:schedule/src/resources/schedule_changes_provider.dart';


class DaysTabControllerState extends State with SingleTickerProviderStateMixin {
  DaysTabControllerState() {
    tabController = new TabController(length: 6, vsync: this);

    DateTime now = DateTime.now();

    firstDay = now.subtract(new Duration(
      days: now.weekday == 7 ? -1 : DateTime.now().weekday - 1,
      hours: now.hour - 3,
      minutes: now.minute,
      seconds: now.second,
      milliseconds: now.millisecond,
      microseconds: now.microsecond
    ));

    int day = now.weekday;
    if (prefs != null && (prefs.getBool('setting_show_next_day') ?? false)) {
      String nextDayTime = prefs.getString('setting_next_day_time');
      TimeOfDay nextTime = TimeOfDay(
          hour: int.parse(nextDayTime.split(':')[0]), 
          minute: int.parse(nextDayTime.split(':')[1])
      );
      if (now.hour >= nextTime.hour && now.minute >= nextTime.minute) {
        day++;
        if (now.weekday == 6) {
          firstDay = firstDay.add(new Duration(days: 7));
        }
        if (day > 7) day = 7;
      }
    }

    ScheduleChangesProvider.setFDay(firstDay);

    tabController.animateTo(day == 7 ? 0 : day - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class DaysTabBar extends StatefulWidget with PreferredSizeWidget{
  final TabController _daysTabController;

  DaysTabBar(this._daysTabController);

  Size get preferredSize => new Size.fromHeight(50.0);

  @override
  DaysTabBarState createState() => new DaysTabBarState(_daysTabController);
}

class DaysTabBarState extends State<DaysTabBar> with SingleTickerProviderStateMixin  {
  TabController _daysTabController;

  DaysTabBarState(this._daysTabController) {
    daysTabBarState = this;
  }
  
  @override
  Widget build(BuildContext context) {
    return  TabBar(
      controller: _daysTabController,
      isScrollable: true,
      tabs: daysOfWeek.map((day) {
        DateTime currentDay = firstDay.add(new Duration(days: daysOfWeek.indexOf(day)));
        return Tab(text: '$day, ${currentDay.day.toString()}.${currentDay.month.toString().padLeft(2, '0')}');
      }).toList()
    );
  }
}

class ScheduleTabBarView extends StatefulWidget {
  final TabController _tabController;

  ScheduleTabBarView(this._tabController);

  @override
  ScheduleTabBarViewState createState() => new ScheduleTabBarViewState(_tabController);
}

class ScheduleTabBarViewState extends State<ScheduleTabBarView> {
  TabController _tabController;

  ScheduleTabBarViewState(this._tabController) {
    tabBarViewState = this;
  }

  @override
  Widget build(BuildContext context) {
    Bloc bloc = savedScheduleMode ? Bloc.saved(scheduleType.lessons, scheduleMode) : Bloc.lessons(scheduleMode);
    // bloc.fetch();

    return new FutureBuilder(
      future: bloc.fetch(),
      builder: (context, AsyncSnapshot snapshot) {
        List<Widget> children = [];
        if (snapshot.connectionState == ConnectionState.waiting) {
         children = [
            Center(child: CircularProgressIndicator()),
            Center(child: CircularProgressIndicator()),
            Center(child: CircularProgressIndicator()),
            Center(child: CircularProgressIndicator()),
            Center(child: CircularProgressIndicator()),
            Center(child: CircularProgressIndicator())
          ];
        } else if (snapshot.connectionState == ConnectionState.done) {
          children = [
            LessonsListView(1, snapshot),
            LessonsListView(2, snapshot),
            LessonsListView(3, snapshot),
            LessonsListView(4, snapshot),
            LessonsListView(5, snapshot),
            LessonsListView(6, snapshot),
          ];
        }
        return TabBarView(
          controller: _tabController,
          children: children
        );
      }
    );
  }
}