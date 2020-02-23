import 'package:flutter/material.dart';
import 'package:schedule/src/resources/divisions.dart';
import 'package:schedule/src/resources/variables.dart';

class ScheduleSelector extends StatefulWidget {
  final int _tabIndex;

  ScheduleSelector(this._tabIndex);

  @override
  createState() => new ScheduleSelectorState(_tabIndex);
}

class ScheduleSelectorState extends State<ScheduleSelector> {
  int _tabIndex;

  ScheduleSelectorState(this._tabIndex);

  @override
  Widget build(BuildContext context) {
    bloc.fetchDivisions();

    return new StreamBuilder(
      stream: bloc.divisions,
      builder: (context, AsyncSnapshot<Divisions> snapshot) {
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

  Widget buildList(AsyncSnapshot<Divisions> snapshot) {
    return new ListView.builder(
      itemCount: snapshot.data.items.length,
      itemBuilder: (BuildContext context, int index) {
        return new Container(
          child: new Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 1.0, bottom: 1.0),
            child: new Column(
              children: <Widget>[
                new Text(snapshot.data.items[index].shortTitle),
                if (snapshot.data.items.length - 1 != index) new Divider(),
              ],
            ),
          ),
        );
      },
    );
  }
}
