import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:schedule/src/models/lesson.dart';
import 'package:schedule/src/resources/variables.dart';

import 'package:schedule/src/resources/schedule_changes_provider.dart';

class Lessons {
  List<Lesson> _items = [];

  Lessons(List<dynamic> items) {
    items.forEach((json) {
      _items.add(new Lesson(json['id_cell'], json['NumberSubGruop'], json['TitleSubject'],
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
  int _teacherId;

  String _classroom;
  String _housing;

  int _timestamp;

  requestType _requestType;

  var response;

  LessonsProvider(this._requestType, this._timestamp, {groupId, teacherId, classroom, housing}) {
    _groupId = groupId;
    _teacherId = teacherId;
    _classroom = classroom;
    _housing = housing;
  }

  Client client = new Client();
  
  fetch() async {
    try{
      switch (_requestType) {
        case requestType.teacher:
          response = await client.get('http://oreluniver.ru/schedule/$_teacherId////$_timestamp/printschedule');
          break;

        case requestType.student:
          response = await client.get('http://oreluniver.ru/schedule//$_groupId///$_timestamp/printschedule');
          break;

        case requestType.classroom:
          response = await client.get('http://oreluniver.ru/schedule///$_housing/$_classroom/$_timestamp/printschedule');
          break;
      }
    } catch(e) {
      return 'Error';
    }

    if (response.statusCode == 200) {
      var map = json.decode(utf8.decode(response.bodyBytes));
      if (map.isEmpty) return Lessons([]);

      List<dynamic> list = List();
      map.forEach((key, value) { list.add(value); });
      list.removeLast();

      ScheduleChangesProvider.setHashSumFromResponse(response);
      
      return new Lessons(list);
    } else {
      return new Lessons([]);
    }
  }
}

class LessonsProviderForStudents {
  int _groupId;
  int _timestamp;

  LessonsProviderForStudents(this._groupId, this._timestamp);

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