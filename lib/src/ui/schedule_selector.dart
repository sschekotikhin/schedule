import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schedule/src/blocs/bloc.dart';
import 'package:schedule/src/models/course.dart';
import 'package:schedule/src/resources/courses.dart';
import 'package:schedule/src/resources/divisions.dart';
import 'package:schedule/src/resources/variables.dart';

class ScheduleSelector extends StatefulWidget {
  final int _tabIndex;
  final selectorMode _mode;

  ScheduleSelector(this._tabIndex, this._mode);

  @override
  createState() => new ScheduleSelectorState(_tabIndex, _mode);
}

class ScheduleSelectorState extends State<ScheduleSelector> {
  int _tabIndex;
  selectorMode _mode;

  int _divisionId = 7, _course = 3;

  Bloc bloc;

  ScheduleSelectorState(this._tabIndex, this._mode);

  @override
  Widget build(BuildContext context) {
    // divisionsBloc.fetchDivisions();
    bloc = new Bloc(_mode, divisionId: _divisionId, course: _course);
    bloc.fetch();

    return new StreamBuilder(
      stream: bloc.data,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot);
        } else if (snapshot.hasError) {
          return new Text(snapshot.error.toString());
        }

        return new Center(
          child: CircularProgressIndicator(),
        );
      }, 
    );
  }

  Widget buildList(AsyncSnapshot snapshot) {
    return new ListView.builder(
      itemCount: snapshot.data.items.length,
      itemBuilder: (BuildContext context, int index) {
        return new Container(
          child: new Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 1.0, bottom: 1.0),
            child: new Column(
              children: <Widget>[
                new FlatButton(
                  onPressed: () {
                    setState(() {
                      switch (_mode) {
                        case selectorMode.division:
                          _divisionId = snapshot.data.items[index].id;
                          _mode = selectorMode.course;
                          break;

                        case selectorMode.course:
                          _course = snapshot.data.items[index].course;
                          _mode = selectorMode.group;
                          break;

                        case selectorMode.group:
                          break;
                      }
                    });
                  }, 
                  child: new Text(getButtonText(snapshot.data.items[index])),
                ),
                if (snapshot.data.items.length - 1 != index) new Divider(),
              ],
            ),
          ),
        );
      },
    );
  }

  String getButtonText(var item) {
    try {
      switch (_mode) {
        case selectorMode.division:
          return item.title;

        case selectorMode.course:
          return item.course.toString();

        case selectorMode.group:
          return item.title;
      }
    } catch (e) {
      return '';
    }
  }

  void onButtonPressed(int id) {

  }
}
