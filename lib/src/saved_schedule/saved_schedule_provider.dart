import 'dart:convert';

import 'package:schedule/src/resources/lessons.dart';
import 'package:schedule/src/resources/exams.dart';
import 'package:schedule/src/resources/variables.dart';

import 'package:schedule/src/saved_schedule/schedule_storage.dart';

class SavedScheduleProvider {
  scheduleType _scheduleType;
  requestType _requestType;
  
  SavedScheduleProvider (this._scheduleType, this._requestType);

  fetch() async {
    var response = await ScheduleStorage.loadSchedule(_scheduleType, _requestType);

    if (response != "") {
      switch (_scheduleType) {
        case scheduleType.lessons:
          var map = json.decode(response);
          if (map.isEmpty) return Lessons([]);

          List<dynamic> list = List();
          map.forEach((key, value) { list.add(value); });
          list.removeLast();
          return new Lessons(list);
        break;

        case scheduleType.exams:
          return new Exams(json.decode(response));
        break;
      }
    } else {
      return savedDataError;
    }
  }    
}