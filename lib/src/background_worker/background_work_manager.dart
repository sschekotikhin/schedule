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

        int firstDay = prefs.getInt('scfirstday') ?? 0;

        String body = '';

        bool isChanged = await ScheduleChangesProvider.chechHashSum(mode, firstDay, groupId: groupId, teacherId: teacherId, classroom: classroom, housing: building);

        body = isChanged ? 'Расписание изменилось!' : 'Изменений не найдено!';

        NotificationManager().showNotificationWithDefaultSound(0, 'Изменения в расписании', body);

        break;
    }
    return Future.value(true);
  });
}

class BackgroundWorkManager {
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