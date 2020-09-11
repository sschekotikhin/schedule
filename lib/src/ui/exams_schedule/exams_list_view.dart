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
              
              IconButton(icon: Icon(Icons.refresh), onPressed: (){ tabBarViewState.setState(() {}); })
            ],
          )
        );
      }

      List<Exam> exams = Exam.examsByType(_type, _snapshot.data.items);

      if (exams.isNotEmpty) {
        return ListView.builder(
          itemCount: exams.length,
          itemBuilder: (BuildContext context, int index) {
            return new Column(
              children: [
                ExamWidget(exams[index])
              ]);     
          }
        );
      } else {
        return new Center(
          child: Text('Занятий не найдено')
        );
      }
    } else if (_snapshot.hasError) {
      return new Text(_snapshot.error.toString());
    }

    // if (_snapshot.data == null) {
    //   return new Center(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.max,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.only(bottom: 15), 
    //           child: Text('Не удалось загрузить данные!'),
    //         ),
            
    //         IconButton(icon: Icon(Icons.refresh), onPressed: (){ tabBarViewState.setState(() {}); })
    //       ],
    //     )
    //   );
    // }

    return new Center(
      child: CircularProgressIndicator(),
    );
  }
}