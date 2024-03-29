import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:schedule/src/models/lesson.dart';

class Lessons {
  List<Lesson> _items = [];

  Lessons(List<dynamic> items) {
    items.forEach((json) {
      _items.add(new Lesson(json['id'], json['NumberSubGruop'], json['TitleSubject'],
                            json['TypeLesson'], json['NumberLesson'], json['DayWeek'],
                            json['Korpus'], json['NumberRoom'], json['special'],
                            json['title'], json['employee_id'], json['Family'],
                            json['Name'], json['SecondName']));
    });
  }

  List<Lesson> get items => _items;
}

class LessonsProvider {
  int _groupId;
  int _timestamp;

  LessonsProvider(this._groupId, this._timestamp);

  Client client = new Client();
  
  Future<Lessons> fetch() async {
    final response = await client.get('http://oreluniver.ru/schedule//$_groupId///$_timestamp/printschedule');

    if (response.statusCode == 200) {
      return new Lessons(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      return new Lessons([]);
    }
  }
}

class LessonsProviderForTeacher {
  int _teacherId;
  int _timestamp;

  LessonsProviderForTeacher(this._teacherId, this._timestamp);

  Client client = new Client();
  
  Future<Lessons> fetch() async {
    final response = await client.get('http://oreluniver.ru/schedule/$_teacherId////$_timestamp/printschedule');

    if (response.statusCode == 200) {
      return new Lessons(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      return new Lessons([]);
    }
  }
}

class LessonsProviderForClassroom {
  String _classroom;
  String _housing;
  int _timestamp;

  LessonsProviderForClassroom(this._housing, this._classroom, this._timestamp);

  Client client = new Client();
  
  Future<Lessons> fetch() async {
    final response = await client.get('http://oreluniver.ru/schedule///$_housing/$_classroom/$_timestamp/printschedule');

    if (response.statusCode == 200) {
      return new Lessons(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      return new Lessons([]);
    }
  }
}