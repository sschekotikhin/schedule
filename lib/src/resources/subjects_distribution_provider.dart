import 'dart:convert';

import 'package:http/http.dart';
import 'package:schedule/src/models/subject_distribution.dart';
import 'package:schedule/src/resources/variables.dart';

class SubjectsDistributions {
  List<SubjectDistribution> _items = [];
  int _startWeek;
  int _endWeek;

  SubjectsDistributions(List items) {
    Map weeksCount = items[0];
    _startWeek = weeksCount['MinWeek'];
    _endWeek = weeksCount['MaxWeek'];

    items.removeAt(0);

    items.forEach((json) {
      String title = json['Subject'];
      String type = json['Type'];
      int count = json['All'];

      json.removeWhere((key, value) => key == 'All' || !(value is int));

      _items.add(new SubjectDistribution(title, [
        SubjectTypeDistribution(type, count, json)
      ]));
    });
  }

  List<SubjectDistribution> get items => _items;
  int get startWeek => _startWeek;
  int get endWeek => _endWeek;
}

class SubjectDistributionProvider {
  int _id;

  requestType _requestType;

  var response;

  SubjectDistributionProvider(this._requestType, this._id);

  Client client = new Client();
  
  fetch() async {
    try{
      switch (_requestType) {
        case requestType.teacher:
          response = await client.get('http://oreluniver.ru/schedule//$_id/printeduproc');
          break;

        case requestType.student:
          response = await client.get('http://oreluniver.ru/schedule/$_id//printeduproc');
          break;

        case requestType.classroom:
          break;
      }
    } catch(e) {
      return 'Error';
    }

    if (response.statusCode == 200) {
      // var map = json.decode(utf8.decode(response.bodyBytes));
      // if (map.isEmpty) return SubjectsDistributions([]);

      // List<dynamic> list = List();
      // map.forEach((key, value) { list.add(value); });
      // list.removeLast();

      return new SubjectsDistributions(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      return new SubjectsDistributions([]);
    }
  }
}