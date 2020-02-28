import 'package:flutter/material.dart';
import 'package:schedule/src/models/lesson.dart';
import 'package:schedule/src/resources/variables.dart';

class LessonWidget extends StatelessWidget {
  final int _number;
  final Lesson _lesson;

  LessonWidget(this._number, this._lesson);

  @override
  Widget build(BuildContext context) {
    return new Card (
      elevation: 0.0,
      margin: EdgeInsets.all(2.0),
      color: Colors.white,
      shape: RoundedRectangleBorder (borderRadius: lessonCardRadius),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: 2.0), borderRadius: lessonCardRadius),
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
        // alignment: Alignment.center,
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text(_lesson.subjectTitle, textAlign: TextAlign.left)),
            //special
            new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('(${_lesson.lessonType})', textAlign: TextAlign.left)),
            new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('${_lesson.housing}-${_lesson.roomNumber}', textAlign: TextAlign.left)),
                new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('${_lesson.lastName} ${_lesson.firstName[0]}.${_lesson.midName[0]}.', textAlign: TextAlign.right))
              ]
            ),
            new Divider(color: Colors.blueGrey, thickness: 1.0, height: 10.0),
            new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('${_lesson.lessonNumber}', textAlign: TextAlign.left, style: TextStyle(color: Colors.blueGrey))),
                new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('${lessonTime[_lesson.lessonNumber - 1]}', textAlign: TextAlign.right, style: TextStyle(color: Colors.blueGrey)))
              ]
            ),
          ],
        )
      )
    );
  }
}
