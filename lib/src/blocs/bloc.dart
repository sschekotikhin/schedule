import 'package:schedule/src/resources/buildings.dart';
import 'package:schedule/src/resources/classrooms.dart';
import 'package:schedule/src/resources/courses.dart';
import 'package:schedule/src/resources/departments.dart';
import 'package:schedule/src/resources/divisions.dart';
import 'package:schedule/src/resources/groups.dart';
import 'package:schedule/src/resources/lessons.dart';
import 'package:schedule/src/resources/teachers.dart';
import 'package:schedule/src/resources/exams.dart';
import 'package:schedule/src/resources/subjects_distribution_provider.dart';
import 'package:schedule/src/saved_schedule/saved_schedule_provider.dart';

import 'package:schedule/src/resources/variables.dart';

class Bloc<T> {
  var _provider;

  Bloc(selectorMode mode) {
    switch (mode) {
      case selectorMode.divisionForStudent:
        this._provider = DivisionsProvider(false);
        break;

      case selectorMode.course:
        this._provider = CoursesProvider(divisionForStudentId);
        break;

      case selectorMode.group:
        this._provider = GroupsProvider(divisionForStudentId, course);
        break;

      case selectorMode.divisionForTeacher:
        this._provider = DivisionsProvider(true);
        break;

      case selectorMode.department:
        this._provider = DepartmentsProvider(divisionForTeacherId);
        break;
      
      case selectorMode.teacher:
        this._provider = TeachersProvider(departmentId);
        break;

      case selectorMode.building:
        this._provider = BuildingsProvider();
        break;

      case selectorMode.classroom:
        this._provider = ClassroomsProvider(building);
        break;
    }
  }

  Bloc.lessons(int mode) {

    switch (mode){
      case 0:
        this._provider = LessonsProvider(requestType.teacher, firstDay.millisecondsSinceEpoch, teacherId: teacherId);
        break;

      case 1:
        this._provider = LessonsProvider(requestType.student, firstDay.millisecondsSinceEpoch, groupId: groupId);
        break;

      case 2:
        this._provider = LessonsProvider(requestType.classroom, firstDay.millisecondsSinceEpoch, housing: building, classroom: classroom);
        break;
    }
  }

  Bloc.exams(int mode) {
    switch (mode){
      case 0:
        this._provider = ExamsProvider(requestType.teacher, id: teacherId);
        break;

      case 1:
        this._provider = ExamsProvider(requestType.student, id: groupId);
        break;

      case 2:
        this._provider = ExamsProvider(requestType.classroom, classroom: classroom, housing: building);
        break;
    }
  }

  Bloc.distribution(int mode) {
    switch (mode){
      case 0:
        this._provider = SubjectDistributionProvider(requestType.teacher, teacherId);
        break;

      case 1:
        this._provider = SubjectDistributionProvider(requestType.student, groupId);
        break;
    }
  }

  Bloc.saved(scheduleType _scheduleType, int mode) {
    switch (mode){
      case 0:
        this._provider = SavedScheduleProvider(_scheduleType, requestType.teacher);
        break;

      case 1:
        this._provider = SavedScheduleProvider(_scheduleType, requestType.student);
        break;

      case 2:
        this._provider = SavedScheduleProvider(_scheduleType, requestType.classroom);
        break;
    }
  }
  

  fetch() async {
    T divisions = await _provider.fetch();
    return divisions;
  }
}
