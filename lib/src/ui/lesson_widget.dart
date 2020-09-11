import 'package:flutter/material.dart';
import 'package:schedule/src/models/lesson.dart';
import 'package:schedule/src/resources/variables.dart';

class LessonWidget extends StatelessWidget {
  final int _number;
  final List<Lesson> _lessons;
  String _subjectTitle, _lessonType, _housing, _roomNumber, _fullName, _title;

  LessonWidget(this._number, this._lessons);

  buildLessonTimeRow() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('${_number + 1}', textAlign: TextAlign.left, style: TextStyle(color: Colors.blueGrey))),
        new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('${lessonTime[_number]}', textAlign: TextAlign.right, style: TextStyle(color: Colors.blueGrey)))
      ]
    );
  }

  buildLessonCard(BuildContext context, Widget childWidget) {
    return Card (
      elevation: 0.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
      shape: RoundedRectangleBorder (borderRadius: lessonCardRadius),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor, width: 2.0), borderRadius: lessonCardRadius),
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
        // alignment: Alignment.center,
        child: childWidget
      )
    );
  }

  buildLessonInfoWidget(String subjectTitle, String lessonType, String leftText, String rightText) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text(subjectTitle, textAlign: TextAlign.left)),
        new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('($lessonType)', textAlign: TextAlign.left)),
        new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Expanded(child: Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text(leftText, textAlign: TextAlign.left))),
            new Expanded(child: Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10.0), child: Text(rightText, textAlign: TextAlign.right)))
          ]
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_lessons.isNotEmpty) {
      _subjectTitle = _lessons[0].subjectTitle;
        _lessonType = _lessons[0].lessonType;
        _housing = _lessons[0].housing;
        _roomNumber = _lessons[0].roomNumber;
        _fullName = _lessons[0].fullName;
        _title = _lessons[0].title;

      String roomText = '$_housing-$_roomNumber';

      if (_lessons.length > 1) {
        if (_lessons[0].subjectTitle != _lessons[1].subjectTitle) {
          List<Widget> children = List<Widget>();
          _lessons.forEach((lesson) {
            String leftText = (scheduleMode == 0 || scheduleMode == 1) ? '${lesson.housing}-${lesson.roomNumber}' : lesson.title;
            String rightText = (scheduleMode == 1 || scheduleMode == 2) ? lesson.fullName : lesson.title;

            children.addAll(
              [
                buildLessonInfoWidget(lesson.subjectTitle, lesson.lessonType, leftText, rightText),
                Divider(color: Colors.blueGrey, thickness: 1.0, height: 10.0)
              ]
            );
          });

          return buildLessonCard(
            context, 
            Column(
              children: children + [buildLessonTimeRow()]
            )
          );
        }

        _lessons.forEach((lesson) {
          if (lesson.fullName != _lessons[0].fullName) {
            _fullName += ', ' + lesson.fullName;
          }
          if (lesson.title != _lessons[0].title) {
            _title += ', ' + lesson.title;
          }
          if (lesson.roomNumber != _lessons[0].roomNumber) {
            roomText += ', ' + '${lesson.housing}-${lesson.roomNumber}';
          }
        });
      }
      
      String leftText = (scheduleMode == 0 || scheduleMode == 1) ? roomText : _title;
      String rightText = (scheduleMode == 1 || scheduleMode == 2) ? _fullName : _title;

      return buildLessonCard(
        context, 
        Column(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildLessonInfoWidget(_subjectTitle, _lessonType, leftText, rightText),
            new Divider(color: Colors.blueGrey, thickness: 1.0, height: 10.0),
            buildLessonTimeRow()
          ],
        )
      );
    }
    else {
      bool hideEmpty = prefs.getBool('setting_hide_empty') ?? false;
      if (!hideEmpty) {
        return buildLessonCard(
          context,
          buildLessonTimeRow()
        );
      } else {
        return Container(height: 0);
      }
    }
  }
}
