import 'dart:convert';

import 'package:http/http.dart';
import 'package:schedule/src/models/classroom.dart';

class Classrooms {
  List<Classroom> _items = [];
  
  Classrooms(List<dynamic> items) {
    items.forEach((json) {
      _items.add(new Classroom(json['NumberRoom']));
    });
  }

  List<Classroom> get items => _items;
}

class ClassroomsProvider {
  String _building;

  ClassroomsProvider(this._building);

  Client client = new Client();

  Future<Classrooms> fetch() async {
    final response = await client.get('http://oreluniver.ru/schedule/$_building/auditlist');

    if (response.statusCode == 200) {
      return new Classrooms(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      return new Classrooms([]);
    }
  }
}