import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:schedule/src/resources/functions.dart';
import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/daysTabBar.dart';
import 'package:schedule/src/ui/schedule_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:schedule/src/ui/appbar.dart';
import 'package:schedule/src/ui/drawer.dart';
import 'package:schedule/src/ui/schedule_bottom_navbar.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //setPreferences();
    //setLastSelectorStates();
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('ru')],
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: Scaffold(
        appBar: ScheduleAppBar(),
        drawer: ScheduleDrawer(),
        bottomNavigationBar: ScheduleBottomNavBar(scheduleMode),
        body: FutureBuilder<String>(
          future: setPreferences(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return new SlidingUpPanel(
                controller: panelController,
                panel: new ScheduleSelector(scheduleMode, lastSelectorStates[scheduleMode]),
                body: ScheduleTabBarView(daysTabBarState.tabController),
                slideDirection: SlideDirection.DOWN,
                borderRadius: slidingPanelRadius,
                minHeight: 0,
                backdropEnabled: true,
                onPanelOpened: () {scheduleSelectorState.loadData = true; scheduleSelectorState.setState((){});},
                onPanelClosed: () {scheduleSelectorState.loadData = false;},
              );
            } 
            else if (snapshot.hasError) {
              return new Text(snapshot.error.toString());
            }

            return new Center(
              child: CircularProgressIndicator(),
            );
          }
        )
      ),
    );
  } 

  Future<String> setPreferences() async {
    prefs = await SharedPreferences.getInstance();
    divisionForStudentId = prefs.getInt('div_stud_id') ?? -1;
    course = prefs.getInt('course') ?? -1;
    groupId = prefs.getInt('group_id') ?? -1;
    divisionForTeacherId = prefs.getInt('div_teach_id') ?? -1;
    departmentId = prefs.getInt('department_id') ?? -1;
    teacherId = prefs.getInt('teacher_id') ?? -1;
    building = prefs.getString('building') ?? '';
    classroom = prefs.getString('classroom') ?? '';
    scheduleMode = prefs.getInt('schedule_mode') ?? 1;
    // ScheduleSelector.setLastSelectorStates();
    // log('set sel');
    bottomNavBarState.setState((){});
    //selectorButtonState.setState((){});
    selectorButtonState.setState(() {
      selectorButtonState.tabIndex = scheduleMode;
    });
    return 'qwerty';
  }
}


