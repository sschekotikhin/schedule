import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import 'package:schedule/src/resources/divisions.dart';

class DepartmentsProvider {
  int _divisionId;

  DepartmentsProvider(this._divisionId);

  Client client = new Client();

  Future<Divisions> fetch() async {
    final response = await client.get('http://oreluniver.ru/schedule/$_divisionId/kaflist');

    if (response.statusCode == 200) {
      return new Divisions(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      return new Divisions([]);
    }
  }
}