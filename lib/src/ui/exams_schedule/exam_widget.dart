import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:schedule/src/models/exam.dart';
import 'package:schedule/src/resources/variables.dart';

class ExamWidget extends StatelessWidget {
  final Exam _exam;

  ExamWidget(this._exam);

  @override
  Widget build(BuildContext context) {
    String leftText = (scheduleMode == 0 || scheduleMode == 1) ? _exam.roomNumber : _exam.group;
    String rightText = (scheduleMode == 1 || scheduleMode == 2) ?  _exam.fullName : _exam.group;
    String day = daysOfWeek[DateFormat('dd.MM.yyyy').parse(_exam.date).weekday - 1];

    return new Card (
      elevation: 0.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
      shape: RoundedRectangleBorder (borderRadius: lessonCardRadius),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor, width: 2.0), borderRadius: lessonCardRadius),
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
        // alignment: Alignment.center,
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text(_exam.subjectTitle, textAlign: TextAlign.left)),
            //special
            new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('(${_exam.lessonType})', textAlign: TextAlign.left)),
            new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Expanded(child: Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text(leftText, textAlign: TextAlign.left))),
                new Expanded(child: Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10.0), child: Text(rightText, textAlign: TextAlign.right)))
              ]
            ),
            new Divider(color: Colors.blueGrey, thickness: 1.0, height: 10.0),
            new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('${_exam.date} ($day)', textAlign: TextAlign.left, style: TextStyle(color: Colors.blueGrey))),
                new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('${_exam.time}', textAlign: TextAlign.right, style: TextStyle(color: Colors.blueGrey)))
              ]
            ),
          ],
        )
      )
    );
  }
}