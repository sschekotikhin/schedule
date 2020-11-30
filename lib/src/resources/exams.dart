import 'dart:convert';
import 'package:http/http.dart';
import 'package:schedule/src/models/exam.dart';
import 'package:schedule/src/resources/variables.dart';

import 'package:schedule/src/saved_schedule/schedule_storage.dart';


class Exams {
  List<Exam> _items = [];

  Exams(List<dynamic> items) {
    items.forEach((json) {
      _items.add(new Exam(json['DBDate'], json['DateLesson'], json['Time'],
                            json['DayWeek'], json['Title'], json['TitleSubject'],
                            json['TypeLesson'], json['NumberRoom'], json['employee_id'],
                            json['Family'], json['Name'], json['SecondName']));
    });
  }

  List<Exam> get items => _items;
}

class ExamsProvider {
  int _id;
  String _classroom;
  String _housing;

  requestType _requestType;

  var response;

  ExamsProvider(this._requestType, {int id, String classroom, String housing}) {
    this._id = id;
    this._classroom = classroom;
    this._housing = housing;
  }

  Client client = new Client();
  
  fetch() async {
    try {
      switch (_requestType) {
        case requestType.teacher:
          response = await client.get('http://oreluniver.ru/schedule//$_id///printexamschedule');
          break;

        case requestType.student:
          response = await client.get('http://oreluniver.ru/schedule/$_id////printexamschedule');
          break;

        case requestType.classroom:
          response = await client.get('http://oreluniver.ru/schedule///$_housing/$_classroom/printexamschedule');
          break;
      }
    } catch(e) {
      return 'Error';
    }

    if (response.statusCode == 200) {
      //Если переделали расписание экзаменов
      // var map = json.decode(utf8.decode(response.bodyBytes));
      // if (map.isEmpty) return Exams([]);

      // List<dynamic> list = List();
      // map.forEach((key, value) { print(value); list.add(value); });
      // list.removeLast();

      // return new Exams(list);
      if (prefs.getBool('setting_save_locally') ?? false) ScheduleStorage.saveSchedule(scheduleType.exams, _requestType, utf8.decode(response.bodyBytes));

      return new Exams(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      return new Exams([]);
    }
  }
}
