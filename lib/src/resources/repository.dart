import 'dart:async';

import 'package:schedule/src/resources/courses.dart';
import 'package:schedule/src/resources/divisions.dart';
import 'package:schedule/src/resources/groups.dart';
import 'package:schedule/src/resources/variables.dart';

// class DivisionsRepository {
//   final divisionsProvider = DivisionsProvider();

//   Future<Divisions> fetchDivisions() => divisionsProvider.fetchDivisions();
// }

// class CoursesRepository {
//   // final int _divisionId;
//   final coursesProvider = CoursesProvider();

//   // CoursesRepository(this._divisionId);

//   Future<Courses> fetchCourses(int divisionId) => coursesProvider.fetchCourses(divisionId);
// }

class Repository<T> {
  var _provider;
  
  Repository(selectorMode mode, {int divisionId, int course}) {
    switch (mode) {
      case selectorMode.division:
        this._provider = DivisionsProvider();
        break;

      case selectorMode.course:
        this._provider = CoursesProvider(divisionId);
        break;

      case selectorMode.group:
        this._provider = GroupsProvider(divisionId, course);
        break;
    }
  }

  Future<T> fetch() => _provider.fetch();
}
