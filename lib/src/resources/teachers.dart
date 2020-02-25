import 'dart:convert';

import 'package:http/http.dart';
import 'package:schedule/src/models/teacher.dart';

class Teachers {
  List<Teacher> _items = [];
  
  Teachers(List<dynamic> items) {
    items.forEach((json) {
      _items.add(new Teacher(json['employee_id'], json['Family'], json['Name'], json['SecondName'], json['fio']));
    });
  }

  List<Teacher> get items => _items;
}

class TeachersProvider {
  int _departmentId;

  TeachersProvider(this._departmentId);

  Client client = new Client();

  Future<Teachers> fetch() async {
    final response = await client.get('http://oreluniver.ru/schedule/$_departmentId/preplist');

    if (response.statusCode == 200) {
      return new Teachers(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      return new Teachers([]);
    }
  }
}