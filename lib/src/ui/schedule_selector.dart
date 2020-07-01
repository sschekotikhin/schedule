import 'package:flutter/material.dart';
import 'package:schedule/src/blocs/bloc.dart';
import 'package:schedule/src/resources/variables.dart';

bool isTeacherDataEmpty() {
  if (divisionForTeacherId == -1 || departmentId == -1 || teacherId == -1) return true;
  else return false;
}

bool isStudentDataEmpty() {
  if (divisionForStudentId == -1 || course == -1 || groupId == -1) return true;
    else return false;
}

bool isClassroomDataEmpty() {
  if (building == '' || classroom == '') return true;
    else return false;
}

void setLastSelectorStates() {
  lastSelectorStates[0] = isTeacherDataEmpty() ? 0 : 2;
  lastSelectorStates[1] = isStudentDataEmpty() ? 0 : 2;
  lastSelectorStates[2] = isClassroomDataEmpty() ? 0 : 1;
}

class ScheduleSelector extends StatefulWidget {
  final int _tabIndex;
  final int _stateIndex;

  ScheduleSelector(this._tabIndex, this._stateIndex) {
    setLastSelectorStates();
  }

  @override
  createState() => new ScheduleSelectorState(_tabIndex, lastSelectorStates[_tabIndex]);
}

class ScheduleSelectorState extends State<ScheduleSelector> {
  int _tabIndex;
  int _stateIndex;
  selectorMode _mode;

  bool _loadData = false;

  set tabIndex(int tabIndex) => _tabIndex = tabIndex;
  set stateIndex(int stateIndex) => _stateIndex = stateIndex;

  set loadData(bool loadData) => _loadData = loadData;

  bool _isBackButtonActive = false, _isForwardButtonActive = false;

  String header = '';

  ScheduleSelectorState(this._tabIndex, this._stateIndex) {
    scheduleSelectorState = this;
    //setLastSelectorStates();
  }
  

  @override
  Widget build(BuildContext context) {
    Bloc bloc;
    _mode = scheduleSelectorStates[_tabIndex][_stateIndex];

    _isBackButtonActive = !(_stateIndex - 1 < 0);
    _isForwardButtonActive = !(_stateIndex + 1 >= scheduleSelectorStates[_tabIndex].length) &&
                              ((_tabIndex == 0 && !isTeacherDataEmpty()) ||
                              (_tabIndex == 1 && !isStudentDataEmpty()) ||
                              (_tabIndex == 2 && !isClassroomDataEmpty()));

    if (_loadData) {
      bloc = new Bloc(_mode);
      bloc.fetch();
    }

    return new Scaffold(
      appBar: PreferredSize(child: Container(), preferredSize: Size.fromHeight(0)),
      body: Container(
        color: Theme.of(context).canvasColor,
        child: Center(
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
                child: _loadData ? new StreamBuilder(
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
                ) : new Center()
              )
            ]
          )
        )
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
                      case selectorMode.divisionForStudent:
                        divisionForStudentId = snapshot.data.items[index].id;
                        prefs.setInt('div_stud_id', divisionForStudentId);
                        break;

                      case selectorMode.course:
                        course = snapshot.data.items[index].course;
                        prefs.setInt('course', course);
                        break;

                      case selectorMode.group:
                        groupId = snapshot.data.items[index].id;
                        header = snapshot.data.items[index].title;
                        prefs.setInt('group_id', groupId);
                        updateHeaders(1, header);
                        break;

                      case selectorMode.divisionForTeacher:
                        divisionForTeacherId = snapshot.data.items[index].id;
                        prefs.setInt('div_teach_id', divisionForTeacherId);
                        break;

                      case selectorMode.department:
                        departmentId = snapshot.data.items[index].id;
                        prefs.setInt('department_id', departmentId);
                        break;
                      
                      case selectorMode.teacher:
                        teacherId = snapshot.data.items[index].id;
                        header = snapshot.data.items[index].fullName;
                        prefs.setInt('teacher_id', teacherId);
                        updateHeaders(0, header);
                        break;

                      case selectorMode.building:
                        building = snapshot.data.items[index].building;
                        prefs.setString('building', building);
                        break;

                      case selectorMode.classroom:
                        classroom = snapshot.data.items[index].number;
                        header = building + ' корпус, ' + classroom;
                        prefs.setString('classroom', classroom);
                        updateHeaders(2, header);
                        break;
                    }

                    nextState();
                  }, 
                  child: new Text(getButtonText(snapshot.data.items[index]), textAlign: TextAlign.center,),
                ),
                (snapshot.data.items.length - 1 != index) ? new Divider() : Container(),
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
        case selectorMode.divisionForStudent:
          return item.title;

        case selectorMode.course:
          return item.course.toString();

        case selectorMode.group:
          return item.title;

        case selectorMode.divisionForTeacher:
          return item.title;

        case selectorMode.department:
          return item.title;
        
        case selectorMode.teacher:
          return item.fullName;

        case selectorMode.building:
          return item.building;

        case selectorMode.classroom:
          return item.number;
      }
    } catch (e) {
      return '';
    }
  }

  String getHeaderText() {
    switch (_mode) {
        case selectorMode.divisionForStudent:
          return 'Выберите институт/факультет';

        case selectorMode.course:
          return 'Выберите курс';

        case selectorMode.group:
          return 'Выберите группу';

        case selectorMode.divisionForTeacher:
          return 'Выберите институт/факультет';

        case selectorMode.department:
          return 'Выберите кафедру';
        
        case selectorMode.teacher:
          return 'Выберите преподавателя';

        case selectorMode.building:
          return 'Выберите корпус';

        case selectorMode.classroom:
          return 'Выберите аудиторию';
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
        lastSelectorStates[_tabIndex] = _stateIndex;
        selectorButtonState.setState(() {
          selectorHeaders[_tabIndex] = header;
        });
        
        //loadSchedule
        tabBarViewState.setState((){});
        panelController.close();
        return;
      }

      _isBackButtonActive = true;
      _mode = scheduleSelectorStates[_tabIndex][++_stateIndex];
    });
  }

  void updateHeaders(int index, String header) {
    List<String> headers = prefs.getStringList('headers');
    if (headers == null) {
      headers = ['','',''];
    }
    headers[index] = header;
    prefs.setStringList('headers', headers);               
  }
}
