import 'package:flutter/material.dart';
import 'package:schedule/src/models/lesson.dart';
import 'package:schedule/src/resources/variables.dart';

class LessonWidget extends StatelessWidget {
  final int _number;
  final List<Lesson> _lessons;
  String _subjectTitle, _lessonType, _housing, _roomNumber, _fullName, _title;

  LessonWidget(this._number, this._lessons);

  @override
  Widget build(BuildContext context) {
    if (_lessons.isNotEmpty) {
      _subjectTitle = _lessons[0].subjectTitle;
        _lessonType = _lessons[0].lessonType;
        _housing = _lessons[0].housing;
        _roomNumber = _lessons[0].roomNumber;
        _fullName = _lessons[0].fullName;
        _title = _lessons[0].title;

      if (_lessons.length > 1) {
        _lessons.forEach((lesson) {
          if (lesson.fullName != _lessons[0].fullName) {
            _fullName += ', ' + lesson.fullName;
          }
          if (lesson.title != _lessons[0].title) {
            _title += ', ' + lesson.title;
          }
        });
      }

      String leftText = (scheduleMode == 0 || scheduleMode == 1) ? '$_housing-$_roomNumber' : _title;
      String rightText = (scheduleMode == 1 || scheduleMode == 2) ? _fullName : _title;

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
              new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text(_subjectTitle, textAlign: TextAlign.left)),
              //special
              new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('($_lessonType)', textAlign: TextAlign.left)),
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
                  new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('${_number + 1}', textAlign: TextAlign.left, style: TextStyle(color: Colors.blueGrey))),
                  new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('${lessonTime[_number]}', textAlign: TextAlign.right, style: TextStyle(color: Colors.blueGrey)))
                ]
              ),
            ],
          )
        )
      );
    }
    else {
      if (!prefs.getBool('setting_hideEmpty')) {
        return new Card (
          elevation: 0.0,
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
          shape: RoundedRectangleBorder (borderRadius: lessonCardRadius),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor, width: 2.0), borderRadius: lessonCardRadius),
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
            // alignment: Alignment.center,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('${_number + 1}', textAlign: TextAlign.left, style: TextStyle(color: Colors.blueGrey))),
                new Padding(padding: EdgeInsets.only(top: 2.5, bottom: 2.5), child: Text('${lessonTime[_number]}', textAlign: TextAlign.right, style: TextStyle(color: Colors.blueGrey)))
              ]
            )
          )
        );
      } else {
        return Container(height: 0);
      }
    }
  }
}
