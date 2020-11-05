import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:schedule/src/resources/schedule_changes_provider.dart';
import 'package:schedule/src/notifications/notification_manager.dart';


void callbackDispatcher() async {
  Workmanager.executeTask((task, inputData) async {
    switch  (task) {
      case '0':
        print("schedule changed");

        var prefs = await SharedPreferences.getInstance();
        
        int mode = prefs.getInt('schedule_mode') ?? 1;
        int groupId = prefs.getInt('group_id') ?? 1;
        int teacherId = prefs.getInt('teacher_id') ?? -1;
        String building = prefs.getString('building') ?? '';
        String classroom = prefs.getString('classroom') ?? '';

        DateTime firstDay = DateTime.now().subtract(new Duration(
          days: DateTime.now().weekday == 7 ? -1 : DateTime.now().weekday - 1,
          hours: DateTime.now().hour - 3,
          minutes: DateTime.now().minute,
          seconds: DateTime.now().second,
          milliseconds: DateTime.now().millisecond,
          microseconds: DateTime.now().microsecond
        ));

        String body = '';

        bool isChanged = await ScheduleChangesProvider.chechHashSum(mode, firstDay.millisecondsSinceEpoch, groupId: groupId, teacherId: teacherId, classroom: classroom, housing: building);

        body = isChanged ? 'Расписание изменилось!' : 'Изменений не найдено!';

        NotificationManager().showNotificationWithDefaultSound(0, 'Изменения в расписании', body);

        break;
    }
    return Future.value(true);
  });
}

class BackgroundWorkManager {
  // static final List<String> _workerNames = ['ScheduleChangesManager'];
  // static final List<String> _workerTags = ['ScheduleChanges'];

  // static List<String> get names => _workerNames;
  // static List<String> get tags => _workerTags;

  static void initWorkManager() async {
    WidgetsFlutterBinding.ensureInitialized(); 
    Workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: false 
    );

    var prefs = await SharedPreferences.getInstance();
    bool checkScheduleChanges = prefs.getBool('setting_check_schedule') ?? false;

    if (checkScheduleChanges) {
      setWorkState(0, true);
    }
  }

  static void cancelWork(int id) {
    Workmanager.cancelByTag(id.toString());
  }

  static void setWorkState(int id, bool state) {
    if (!state) {
      cancelWork(id);
    } else {
      switch (id) {
        case 0:
          Workmanager.registerPeriodicTask(
            "0", //id
            "0", //name
            tag: "0", //tag
            initialDelay: Duration(minutes: 2),
            frequency: Duration(hours: 2),
            constraints: Constraints(
              networkType: NetworkType.connected
            ),
            backoffPolicy: BackoffPolicy.linear,
            backoffPolicyDelay: Duration(minutes: 1)
          );
        break;
      }
    }
  }
}