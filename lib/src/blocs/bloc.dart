import 'package:rxdart/rxdart.dart';
import 'package:schedule/src/resources/buildings.dart';
import 'package:schedule/src/resources/classrooms.dart';
import 'package:schedule/src/resources/courses.dart';
import 'package:schedule/src/resources/departments.dart';
import 'package:schedule/src/resources/divisions.dart';
import 'package:schedule/src/resources/groups.dart';
import 'package:schedule/src/resources/teachers.dart';

import 'package:schedule/src/resources/variables.dart';

// class DivisionsBloc {
//   final _repository = new DivisionsRepository();
//   final _divisionsFetcher = new PublishSubject<Divisions>();

//   Observable<Divisions> get divisions => _divisionsFetcher.stream;

//   fetchDivisions() async {
//     Divisions divisions = await _repository.fetchDivisions();
//     _divisionsFetcher.sink.add(divisions);
//   }

//   dispose() {
//     _divisionsFetcher.close();
//   }
// }

class Bloc<T> {
  var _provider;
  
  final _divisionsFetcher = new PublishSubject<T>();

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
  
  Observable<T> get data => _divisionsFetcher.stream;

  fetch() async {
    T divisions = await _provider.fetch();
    _divisionsFetcher.sink.add(divisions);
  }

  dispose() {
    _divisionsFetcher.close();
  }
}
