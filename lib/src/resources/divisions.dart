import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import 'package:schedule/src/models/division.dart';

class Divisions {
  List<Division> _items = [];

  Divisions(List<dynamic> items) {
    items.forEach((json) {
      _items.add(new Division(json['idDivision'], json['titleDivision'], json['shortTitle']));
    });
  }

  List<Division> get items => _items;
}

class DivisionsProvider {
  bool _isForTeacher;
  String _url;

  DivisionsProvider(this._isForTeacher) {
    _url = _isForTeacher ? 'divisionlistforpreps' : 'divisionlistforstuds';
  }

  Client client = new Client();
  
  Future<Divisions> fetch() async {
    final response = await client.get('http://oreluniver.ru/schedule/' + _url);

    if (response.statusCode == 200) {
      return new Divisions(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      return new Divisions([]);
    }
  }
}
