import 'dart:io';
import 'package:schedule/src/resources/variables.dart';
import 'package:path_provider/path_provider.dart';

class ScheduleStorage {
  static final String _subfolder = 'scsaves';
  static Future<String> _localPath() async {
    var directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static void saveSchedule(scheduleType _scheduleType, requestType _requestType, String response) async {
    if (firstDay.millisecondsSinceEpoch != prefs.getInt('scfirstday') ?? 0) return;
    
    String filename = await _localPath() + "/$_subfolder/${_scheduleType.index}${_requestType.index}.json";
    try {
      Directory(await _localPath() + "/$_subfolder").createSync();
      File file = File(filename);
      if (!file.existsSync()) {
        file.createSync();
      }
      file.writeAsString(response);
    } catch (e) {
      print(e);
    }
  }

  static Future<String> loadSchedule(scheduleType _scheduleType, requestType _requestType) async {
    String filename = await _localPath() + "/$_subfolder/${_scheduleType.index}${_requestType.index}.json";
    try {
      File file = File(filename);
      if (await file.exists()) {
        return file.readAsString();
      } else {
        return "";
      }
    } catch (e) {
      print(e);
    }
    return "";
  }

  static void clearSavedSchedule() async {
    String path = await _localPath() + "/$_subfolder";
    Directory dir = Directory(path);
    dir.deleteSync(recursive: true);
  }
}