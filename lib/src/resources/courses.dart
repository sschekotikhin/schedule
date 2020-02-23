import 'dart:convert';

import 'package:http/http.dart';
import 'package:schedule/src/models/course.dart';

class Courses {
  List<Course> _items = [];
  
  Courses(List<dynamic> items) {
    items.forEach((json) {
      _items.add(new Course(json['kurs']));
    });
  }

  List<Course> get items => _items;
}

class CoursesProvider {
  int _divisionId;

  CoursesProvider(this._divisionId);

  Client client = new Client();

  Future<Courses> fetchCourses() async {
    final response = await client.get('http://oreluniver.ru/schedule/$_divisionId/kurslist');

    if (response.statusCode == 200) {
      return new Courses(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      return new Courses([]);
    }
  }
}
