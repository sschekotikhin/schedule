import 'package:flutter/material.dart';
import 'package:schedule/src/blocs/bloc.dart';
import 'package:schedule/src/resources/variables.dart';

class ScheduleSelector extends StatefulWidget {
  final int _tabIndex;
  final int _stateIndex;

  ScheduleSelector(this._tabIndex, this._stateIndex);

  @override
  createState() => new ScheduleSelectorState(_tabIndex, _stateIndex);
}

class ScheduleSelectorState extends State<ScheduleSelector> {
  int _tabIndex;
  int _stateIndex;
  selectorMode _mode;

  int _divisionId = -1, _course = -1;

  bool _isBackButtonActive = false, _isForwardButtonActive = false;

  ScheduleSelectorState(this._tabIndex, this._stateIndex) {
    _mode = scheduleSelectorStates[_tabIndex][_stateIndex];
    _isBackButtonActive = !(_stateIndex - 1 < 0);
    _isForwardButtonActive = !(_stateIndex + 1 >= scheduleSelectorStates[_tabIndex].length) &&
                              (_divisionId != -1) && (_course != -1);
  }


  @override
  Widget build(BuildContext context) {
    Bloc bloc = new Bloc(_mode, divisionId: _divisionId, course: _course);
    bloc.fetch();

    return new Center(
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new IconButton(icon: Icon(Icons.arrow_back), onPressed: _isBackButtonActive ? prevState : null),
              new Expanded(
                child: new Text(getHeaderText(), textAlign: TextAlign.center)
              ),
              new IconButton(icon: Icon(Icons.arrow_forward), onPressed: _isForwardButtonActive ? nextState : null)
            ],
          ),
          Expanded(
            child: new StreamBuilder(
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
            )
          )
        ]
      )
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
                    switch (_mode) {
                      case selectorMode.division:
                        _divisionId = snapshot.data.items[index].id;
                        break;

                      case selectorMode.course:
                        _course = snapshot.data.items[index].course;
                        break;

                      case selectorMode.group:
                        break;
                    }

                    nextState();
                  }, 
                  child: new Text(getButtonText(snapshot.data.items[index]), textAlign: TextAlign.center,),
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

  String getHeaderText() {
    switch (_mode) {
        case selectorMode.division:
          return 'Выберите институт/факультет';

        case selectorMode.course:
          return 'Выберите курс';

        case selectorMode.group:
          return 'Выберите группу';
      }
  }

  void prevState() {
    setState(() {
      if (_stateIndex - 1 <= 0) {
        _isBackButtonActive = false;
      }
      
      _isForwardButtonActive = true;
      _mode = scheduleSelectorStates[_tabIndex][--_stateIndex];
    });
  }

  void nextState() {
    setState(() {
      if (_stateIndex + 1 == scheduleSelectorStates[_tabIndex].length - 1) {
        _isForwardButtonActive = false;
      } else if (_stateIndex + 1 >= scheduleSelectorStates[_tabIndex].length) {
        //loadSchedule
        return;
      }

      _isBackButtonActive = true;
      _mode = scheduleSelectorStates[_tabIndex][++_stateIndex];
    });
  }
}
