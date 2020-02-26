import 'package:flutter/material.dart';
import 'package:schedule/src/ui/schedule_selector.dart';
import 'package:schedule/src/ui/schedule_selector_button.dart';
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

PanelController panelController = new PanelController();

ScheduleSelectorState scheduleSelectorState;

ScheduleSelectorButtonState selectorButtonState;

int defaultScheduleMode = 1;

int scheduleMode = 1; //load

List scheduleSelectorStates = [
  [selectorMode.divisionForTeacher, selectorMode.department, selectorMode.teacher],
  [selectorMode.divisionForStudent, selectorMode.course, selectorMode.group],
  [selectorMode.building, selectorMode.classroom]
];

List<int> lastSelectorStates = [0, 0, 0]; //load

List<String> selectorHeaders = ['Выберите преподавателя', 'Выберите группу', 'Выберите аудиторию']; //load

int divisionForStudentId = -1, course = -1, groupId = -1, //load
    divisionForTeacherId = -1, departmentId = -1, teacherId = -1; //load

String building = '', classroom = ''; //load