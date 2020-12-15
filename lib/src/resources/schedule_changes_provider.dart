import 'dart:convert';

import 'package:http/http.dart';
import 'package:crypto/crypto.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:schedule/src/resources/variables.dart';

class ScheduleChangesProvider {
  static int fDayMilliseconds;

  static void setFDay(DateTime dateTime) {
    fDayMilliseconds = dateTime.millisecondsSinceEpoch;
    prefs.setInt('scfirstday', firstDay.millisecondsSinceEpoch);
  }

  static void setHashSumFromResponse(Response response) async {  
    if (firstDay.millisecondsSinceEpoch != fDayMilliseconds) return;

    List<int> bytes = utf8.encode(response.body);
    String hash = sha256.convert(bytes).toString();
    
    prefs.setString('schash', hash);
  }

  static Future<bool> chechHashSum(requestT, timestamp, {groupId, teacherId, classroom, housing}) async {
    var response;

    try {
      switch (requestT) {
        case 0:
          response = await Client().get('http://oreluniver.ru/schedule/$teacherId////$timestamp/printschedule');
          break;

        case 1:
          response = await Client().get('http://oreluniver.ru/schedule//$groupId///$timestamp/printschedule');
          break;

        case 2:
          response = await Client().get('http://oreluniver.ru/schedule///$housing/$classroom/$timestamp/printschedule');
          break;
      }
    } catch(e) {
      return false;
    }

    List<int> bytes = utf8.encode(response.body);
    String newHash = sha256.convert(bytes).toString();


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String oldHash = prefs.getString('schash') ?? '';
    if (oldHash != '') {
      return (oldHash != newHash);
    } else {
      return false;
    }

    return true;
  }
}
