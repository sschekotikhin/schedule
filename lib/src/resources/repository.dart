import 'dart:async';

import 'package:schedule/src/resources/divisions.dart';

class Repository {
  final divisionsProvider = DivisionsProvider();

  Future<Divisions> fetchDivisions() => divisionsProvider.fetchDivisions();
}
