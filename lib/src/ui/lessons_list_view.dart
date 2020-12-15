import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/src/models/lesson.dart';
import 'package:schedule/src/ui/lesson_widget.dart';
import 'package:schedule/src/resources/variables.dart';

class LessonsListView extends StatelessWidget {
  // final List<Lesson> _lessons;
  final int _day;
  final AsyncSnapshot _snapshot;
  // final Bloc _bloc;

  LessonsListView(this._day, this._snapshot);

  Widget buildUpdateButton() {
    return IconButton(icon: Icon(Icons.refresh), onPressed: (){
      savedScheduleMode = false; 
      tabBarViewState.setState((){});
      appbarState.setState((){});
      bottomNavBarState.setState((){});
    });
  }

  Widget buildUpdateMessage(BuildContext context) {
    return new Card (
      elevation: 0.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
      shape: RoundedRectangleBorder (borderRadius: lessonCardRadius),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor, width: 2.0), borderRadius: lessonCardRadius),
        // padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
        // alignment: Alignment.center,
        child:Row (
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Сохраненное расписание!'),
            buildUpdateButton()
          ],
        ),
      )
    );
  }

  Widget buildLessonsList(BuildContext context, List<Lesson> lessons) {
    return new Column(
      children: <Widget>[
        savedScheduleMode ? buildUpdateMessage(context) : Container(),
        Expanded(
          child: lessons.isNotEmpty ? 
            ListView.builder(
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return new Column(
                  children: [
                    LessonWidget(index, Lesson.lessonsByNumber(index + 1, lessons))
                  ]);     
              }
            )
          : new Center(
            child: Text('Занятий не найдено')
          )
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_snapshot.hasData) {
      if (_snapshot.data == 'Error') {
        return new Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 15), 
                child: Text('Не удалось загрузить данные!'),
              ),
              // IconButton(icon: Icon(Icons.refresh), onPressed: (){ tabBarViewState.setState(() {}); })
              buildUpdateButton(),
              prefs.getBool('setting_save_locally') ?? false ? Padding(
                padding: EdgeInsets.only(top: 15),
                child:  OutlineButton(
                  child: Text('Сохраненное расписание'),
                  onPressed: (){
                    savedScheduleMode = true;
                    firstDay = DateTime.fromMillisecondsSinceEpoch(prefs.getInt('scfirstday'));
                    tabBarViewState.setState((){});
                    appbarState.setState((){});
                    bottomNavBarState.setState((){});
                  }
                )
              ) : Container()
            ],
          )
        );
      } else if (_snapshot.data == savedDataError) {
        return new Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 15), 
                child: Text('Сохраненные данные отсутствуют!'),
              ),
              // IconButton(icon: Icon(Icons.refresh), onPressed: (){ tabBarViewState.setState(() {}); })
              buildUpdateButton(),
            ],
          )
        );
      }

      List<Lesson> lessons = Lesson.lessonsByDay(_day, _snapshot.data.items);
      return buildLessonsList(context, lessons);
      // return Column(
      //   children: <Widget>[
      //     savedScheduleMode ? buildUpdateMessage(context) : Container(),
      //     Expanded(
      //       child: lessons.isNotEmpty ? 
      //         ListView.builder(
      //           itemCount: 8,
      //           itemBuilder: (BuildContext context, int index) {
      //             return new Column(
      //               children: [
      //                 LessonWidget(index, Lesson.lessonsByNumber(index + 1, lessons))
      //               ]
      //             );     
      //           }
      //         )
      //       : new Center(
      //         child: Text('Занятий не найдено')
      //       )
      //     )
      //   ]
      // );

      // if (lessons.isNotEmpty) {
      //   return ListView.builder(
      //     itemCount: 8,
      //     itemBuilder: (BuildContext context, int index) {
      //       return new Column(
      //         children: [
      //           LessonWidget(index, Lesson.lessonsByNumber(index + 1, lessons))
      //         ]);     
      //     }
      //   );
      // } else {
      //   return new Center(
      //     child: Text('Занятий не найдено')
      //   );
      // }
    } else if (_snapshot.hasError) {
      return new Center(child: Text('Ошибка!'));
    }

    return new Center(
      child: CircularProgressIndicator(),
    );
  }
}