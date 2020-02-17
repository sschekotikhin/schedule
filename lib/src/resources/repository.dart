import 'dart:async';

import 'divisions.dart';

class Repository {
  final divisionsProvider = DivisionsProvider();

  Future<Divisions> fetchDivisions() => divisionsProvider.fetchDivisions();
}
