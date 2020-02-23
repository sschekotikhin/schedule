import 'package:rxdart/rxdart.dart';
import 'package:schedule/src/resources/courses.dart';
import 'package:schedule/src/resources/divisions.dart';
import 'package:schedule/src/resources/groups.dart';

import 'package:schedule/src/resources/repository.dart';
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

  Bloc(selectorMode mode, {int divisionId, int course}) {
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
  
  Observable<T> get data => _divisionsFetcher.stream;

  fetch() async {
    T divisions = await _provider.fetch();
    _divisionsFetcher.sink.add(divisions);
  }

  dispose() {
    _divisionsFetcher.close();
  }
}
