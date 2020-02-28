import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/src/models/lesson.dart';
import 'package:schedule/src/blocs/bloc.dart';
import 'package:schedule/src/ui/lesson_widget.dart';

class LessonsListView extends StatelessWidget {
  // final List<Lesson> _lessons;
  final int _day;
  final AsyncSnapshot _snapshot;
  // final Bloc _bloc;

  LessonsListView(this._day, this._snapshot);

  @override
  Widget build(BuildContext context) {
    if (_snapshot.hasData) {
      List<Lesson> lessons = Lesson.lessonsByDay(_day, _snapshot.data.items);

      return new ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: new Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
              child: new Column(
                children: <Widget>[
                  new LessonWidget(0, lessons[index]),
                ],
              ),
            ),
          );
        },
      );
    } else if (_snapshot.hasError) {
      return new Text(_snapshot.error.toString());
    }

    return new Center(
      child: CircularProgressIndicator(),
    );
  }
}