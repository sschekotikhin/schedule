import 'package:flutter/material.dart';
import 'package:schedule/src/models/exam.dart';
import 'package:schedule/src/resources/variables.dart';

import 'package:schedule/src/ui/exams_schedule/exam_widget.dart';

class ExamsListView extends StatelessWidget {
  final examType _type;
  final AsyncSnapshot _snapshot;

  ExamsListView(this._type, this._snapshot);

  @override
  Widget build(BuildContext context) {
    if (_snapshot.hasData) {
      List<Exam> exams = Exam.examsByType(_type, _snapshot.data.items);

      if (exams.isNotEmpty) {
        return new Padding(
          padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 190),
          //padding: EdgeInsets.all(0),
          child: ListView.builder(
            itemCount: exams.length,
            itemBuilder: (BuildContext context, int index) {
              return new Column(
                children: [
                  ExamWidget(exams[index])
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