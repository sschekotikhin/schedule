import 'package:schedule/src/ui/divisions_list.dart';
import 'package:schedule/src/ui/appbar.dart';
import 'package:schedule/src/ui/drawer.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: ScheduleAppBar(),
        drawer: ScheduleDrawer(),
        body: DivisionsList(),
      ),
    );
  }
}
