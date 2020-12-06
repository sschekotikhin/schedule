import 'package:flutter/material.dart';
import 'package:schedule/src/models/subject_distribution.dart';
import 'ld_appbar.dart';
import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/schedule_selector.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:schedule/src/ui/drawer.dart';
import 'package:schedule/src/blocs/bloc.dart';
import 'subject_widget.dart';

class LessonsDistributionPage extends StatefulWidget {
  @override
  LessonsDistributionPageState createState() => LessonsDistributionPageState();
}

class LessonsDistributionPageState extends State<LessonsDistributionPage> {
  LessonsDistributionPageState() {
    tabBarViewState = this;
  }

  buildSubjectTile() {
    //ExpansionPanel?
    return ExpansionTile(
      title: Text('Предмет номер 1'),
      children: [
        DataTable(
          columns: [
            DataColumn(label: Text('asdasd')),
            DataColumn(label: Text('1'))
          ], 
          rows: [
            DataRow(cells: [
              DataCell(Text('1')),
              DataCell.empty
            ])
          ]
        )
      ],
    );
  }

  buildDistributionBodyWidget() {
    Bloc bloc = new Bloc.distribution(scheduleMode);
    bloc.fetch();

    return new FutureBuilder(
      future: bloc.fetch(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == 'Error') {
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

          // List<Exam> exams = Exam.examsByType(_type, _snapshot.data.items);
          List<SubjectDistribution> subjects = SubjectDistribution.collapseSubjects(snapshot.data.items);

          if (subjects.isNotEmpty) {
            return ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (BuildContext context, int index) {
                return SubjectWidget(subjects[index], snapshot.data.startWeek, snapshot.data.endWeek);
              }
            );
          } else {
            return new Center(
              child: Text('Занятий не найдено')
            );
          }
        } else if (snapshot.hasError) {
          return new Center(child: Text('Ошибка!'));
        }

        return new Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    if (scheduleMode == 2) scheduleMode = 0;
    return Scaffold(
      body: SlidingUpPanel(
        controller: panelController,
        panel: new ScheduleSelector(scheduleMode, lastSelectorStates[scheduleMode]),
        slideDirection: SlideDirection.DOWN,
        borderRadius: slidingPanelRadius,
        minHeight: 0,
        backdropEnabled: true,
        onPanelOpened: () {scheduleSelectorState.loadData = true; scheduleSelectorState.setState((){});},
        onPanelClosed: () {scheduleSelectorState.loadData = false;},
        body: Scaffold(
          appBar: LDAppBar(),
          drawer: ScheduleDrawer(),
          body: buildDistributionBodyWidget()
        )
      )
    );
  }
}