import 'package:flutter/material.dart';
import 'package:schedule/src/models/exam.dart';
import 'package:schedule/src/resources/variables.dart';

import 'package:schedule/src/ui/exams_schedule/exam_widget.dart';

class ExamsListView extends StatelessWidget {
  final examType _type;
  final AsyncSnapshot _snapshot;

  ExamsListView(this._type, this._snapshot);

  Widget buildUpdateButton() {
    return IconButton(icon: Icon(Icons.refresh), onPressed: (){
      savedScheduleMode = false; 
      tabBarViewState.setState(() {}); 
      appbarState.setState((){});
    });
  }

  Widget buildUpdateMessage(BuildContext context) {
    return new Card (
      elevation: 0.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
      shape: RoundedRectangleBorder (borderRadius: lessonCardRadius),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor, width: 2.0), borderRadius: lessonCardRadius),
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
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

  Widget buildExamsList(BuildContext context, List<Exam> exams) {
    return new Column(
      children: <Widget>[
        savedScheduleMode ? buildUpdateMessage(context) : Container(),
        Expanded(
          child: exams.isNotEmpty ? 
            ListView.builder(
              itemCount: exams.length,
              itemBuilder: (BuildContext context, int index) {
                return new Column(
                  children: [
                    ExamWidget(exams[index])
                  ]
                );     
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
              buildUpdateButton(),
              prefs.getBool('setting_save_locally') ?? false ? Padding(
                padding: EdgeInsets.only(top: 15),
                child:  OutlineButton(
                  child: Text('Сохраненное расписание'),
                  onPressed: (){
                    savedScheduleMode = true;
                    tabBarViewState.setState((){});
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
              buildUpdateButton(),
            ],
          )
        );
      }

      List<Exam> exams = Exam.examsByType(_type, _snapshot.data.items);
      return buildExamsList(context, exams);
    } else if (_snapshot.hasError) {
      return new Center(child: Text('Ошибка!'));
    }

    return new Center(
      child: CircularProgressIndicator(),
    );
  }
}