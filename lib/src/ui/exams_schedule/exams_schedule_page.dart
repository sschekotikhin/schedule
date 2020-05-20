import 'package:flutter/material.dart';

import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/schedule_selector.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:schedule/src/ui/exams_schedule/exams_appbar.dart';
import 'package:schedule/src/ui/exams_schedule/exams_tab_view.dart';

import 'package:schedule/src/ui/drawer.dart';
import 'package:schedule/src/ui/schedule_bottom_navbar.dart';
import 'package:schedule/src/ui/exams_schedule/exams_bottom_bar.dart';

class ExamsSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //setPreferences();
    //setLastSelectorStates();
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: ExamsAppBar(),
          drawer: ScheduleDrawer(),
          bottomNavigationBar: ExamsBottomNavBar(scheduleMode),
          body: SlidingUpPanel(
            controller: panelController,
            panel: new ScheduleSelector(scheduleMode, lastSelectorStates[scheduleMode]),
            body: ExamsTabBarView(),
            slideDirection: SlideDirection.DOWN,
            borderRadius: slidingPanelRadius,
            minHeight: 0,
            backdropEnabled: true,
            onPanelOpened: () {scheduleSelectorState.loadData = true; scheduleSelectorState.setState((){});},
            onPanelClosed: () {scheduleSelectorState.loadData = false;},
          )
        )
      )
    );
  }
}