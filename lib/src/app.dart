import 'package:flutter/material.dart';
import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/schedule_selector.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:schedule/src/ui/appbar.dart';
import 'package:schedule/src/ui/drawer.dart';
import 'package:schedule/src/ui/schedule_bottom_navbar.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: ScheduleAppBar(),
        drawer: ScheduleDrawer(),
        bottomNavigationBar: ScheduleBottomNavBar(defaultScheduleMode),
        body: new SlidingUpPanel(
          controller: panelController,
          panel: new ScheduleSelector(defaultScheduleMode, 0),
          body: null,
          slideDirection: SlideDirection.DOWN,
          borderRadius: slidingPanelRadius,
          minHeight: 0,
          backdropEnabled: true,
        ),
      ),
    );
  }
}
