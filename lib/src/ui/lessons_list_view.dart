import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/src/models/lesson.dart';
import 'package:schedule/src/resources/variables.dart';
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

      if (lessons.isNotEmpty) {
        return new Padding(
          padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 0.0, bottom: 130.0),
          child: ListView.builder(
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return new Column(
                children: [
                  LessonWidget(index, Lesson.lessonsByNumber(index + 1, lessons))
                ]);     
            }
          )
        );
      } else {
        return new Center(
          child: Text('Занятий не найдено')
        );
      }
    } else if (_snapshot.hasError) {
      return new Text(_snapshot.error.toString());
    }

    return new Center(
      child: CircularProgressIndicator(),
    );
  }
}