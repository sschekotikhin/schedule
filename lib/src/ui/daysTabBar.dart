import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/src/blocs/bloc.dart';
import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/lessons_list_view.dart';

class DaysTabBar extends StatefulWidget {
  @override
  DaysTabBarState createState() => new DaysTabBarState();
}

class DaysTabBarState extends State<DaysTabBar> with SingleTickerProviderStateMixin  {
  TabController daysTabController;

  DaysTabBarState() {
    daysTabBarState = this;
  }

  TabController get tabController => daysTabController;
  
  @override
  void initState() {
    super.initState();
    daysTabController = new TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) { 
    //DateTime firstDay = DateTime.now().subtract(new Duration(days: DateTime.now().weekday));

    return Scaffold (
      appBar: PreferredSize(
        child: AppBar(
          bottom: TabBar(
            controller: daysTabController,
            isScrollable: true,
            tabs: daysOfWeek.map((day) {
              DateTime currentDay = firstDay.add(new Duration(days: daysOfWeek.indexOf(day) + 1));
              return Tab(text: '$day, ${currentDay.day.toString()}.${currentDay.month.toString().padLeft(2, '0')}');
            }).toList()
          )
        ), 
        preferredSize: Size.fromHeight(50.0)
      ),
      body: ScheduleTabBarView(daysTabController)
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
    // TODO: implement build
    Bloc bloc = new Bloc.fromString(scheduleMode);
    bloc.fetch();

    return new StreamBuilder(
      stream: bloc.data,
      builder: (context, AsyncSnapshot snapshot) {
        return TabBarView(
          controller: _tabController,
          children: [
            LessonsListView(1, snapshot),
            LessonsListView(2, snapshot),
            LessonsListView(3, snapshot),
            LessonsListView(4, snapshot),
            LessonsListView(5, snapshot),
            LessonsListView(6, snapshot),
          ]
        );
      }
    );
  }
}