import 'package:rxdart/rxdart.dart';

import 'package:schedule/src/resources/divisions.dart';
import 'package:schedule/src/resources/repository.dart';

class DivisionsBloc {
  final _repository = new Repository();
  final _divisionsFetcher = new PublishSubject<Divisions>();

  Observable<Divisions> get divisions => _divisionsFetcher.stream;

  fetchDivisions() async {
    Divisions divisions = await _repository.fetchDivisions();
    _divisionsFetcher.sink.add(divisions);
  }

  dispose() {
    _divisionsFetcher.close();
  }
}
