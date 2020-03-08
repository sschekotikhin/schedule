import 'package:flutter/material.dart';
import 'package:schedule/src/ui/daysTabBar.dart';
import 'package:schedule/src/ui/schedule_bottom_navbar.dart';
import 'package:schedule/src/ui/schedule_selector.dart';
import 'package:schedule/src/ui/schedule_selector_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum selectorMode {
  divisionForStudent,
  course,
  group,
  divisionForTeacher,
  department,
  teacher,
  building,
  classroom
}

BorderRadius slidingPanelRadius = new BorderRadius.only(
  bottomLeft: Radius.circular(24.0),
  bottomRight: Radius.circular(24.0)
);


BorderRadius lessonCardRadius = new BorderRadius.only(
  bottomLeft: Radius.circular(10.0),
  bottomRight: Radius.circular(10.0),
  topLeft: Radius.circular(10.0),
  topRight: Radius.circular(10.0)
);

SharedPreferences prefs;

PanelController panelController = new PanelController();

ScheduleSelectorState scheduleSelectorState;

ScheduleSelectorButtonState selectorButtonState;

ScheduleBottomNavBarState bottomNavBarState;

DaysTabBarState daysTabBarState;
ScheduleTabBarViewState tabBarViewState;

ThemeData lightTheme = ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light);
ThemeData darkTheme = ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark);

DateTime firstDay = DateTime.now().subtract(new Duration(
  days: DateTime.now().weekday == 7 ? -1 : DateTime.now().weekday - 1,
  hours: DateTime.now().hour - 3,
  minutes: DateTime.now().minute,
  seconds: DateTime.now().second,
  milliseconds: DateTime.now().millisecond,
  microseconds: DateTime.now().microsecond
));

int scheduleMode = 1; //load

List scheduleSelectorStates = [
  [selectorMode.divisionForTeacher, selectorMode.department, selectorMode.teacher],
  [selectorMode.divisionForStudent, selectorMode.course, selectorMode.group],
  [selectorMode.building, selectorMode.classroom]
];

List<int> lastSelectorStates = [0, 0, 0];

List<String> selectorHeaders = ['Выберите преподавателя', 'Выберите группу', 'Выберите аудиторию']; //load

int divisionForStudentId = -1, course = -1, groupId = -1, //load
    divisionForTeacherId = -1, departmentId = -1, teacherId = -1; //load

String building = '', classroom = ''; //load

List<String> daysOfWeek = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'];

List<String> lessonTime = [
  '8:30 - 10:00',
  '10:10 - 11:40',
  '12:00 - 13:30',
  '13:40 - 15:10',
  '15:20 - 16:50',
  '17:00 - 18:30',
  '18:40 - 20:10',
  '20:15 - 21:45'
];