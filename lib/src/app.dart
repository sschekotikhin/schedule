import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/schedule_selector.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:schedule/src/ui/divisions_list.dart';
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
        bottomNavigationBar: ScheduleBottomNavBar(defaultScheduleMod),
        body: new SlidingUpPanel(
          controller: panelController,
          panel: new Center(
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new IconButton(icon: Icon(Icons.arrow_back), onPressed: () {log('back');}),
                    new Expanded(
                      child: new Text('Институт', textAlign: TextAlign.center)
                    ),
                    new IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {log('forward');})
                  ],
                ),
                Expanded(
                  child: new ScheduleSelector(defaultScheduleMod, selectorMode.division)
                )
              ]
            )
          ),
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
