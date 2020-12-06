import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/daysTabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:schedule/src/ui/lessons_schedule_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //setPreferences();
    //setLastSelectorStates();
    return new MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('ru')],
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: FutureBuilder (
        future: setPreferences(),
        // future: Future<bool>.delayed(
        //   Duration(seconds: 3),
        //   () => true
        // ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            DaysTabControllerState();
            return LessonsSchedulePage();
          } 
          else if (snapshot.hasError) {
            return new Center(child: Text('Ошибка!'));
          }

          return new Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      )
    );
  } 

  Future setPreferences() async {
    // await Future<bool>.delayed(
    //       Duration(seconds: 1),
    //       () => true
    //     );
    if (prefs == null) prefs = await SharedPreferences.getInstance();

    divisionForStudentId = prefs.getInt('div_stud_id') ?? -1;
    course = prefs.getInt('course') ?? -1;
    groupId = prefs.getInt('group_id') ?? -1;
    divisionForTeacherId = prefs.getInt('div_teach_id') ?? -1;
    departmentId = prefs.getInt('department_id') ?? -1;
    teacherId = prefs.getInt('teacher_id') ?? -1;
    building = prefs.getString('building') ?? '';
    classroom = prefs.getString('classroom') ?? '';
    scheduleMode = prefs.getInt('schedule_mode') ?? 1;
    // ScheduleSelector.setLastSelectorStates();
    // log('set sel');
    
    //selectorButtonState.setState((){});
    
    // bottomNavBarState.setState((){});
    // selectorButtonState.setState(() {
    //   selectorButtonState.tabIndex = scheduleMode;
    // });

    return 0;
  }
}


