import 'package:flutter/material.dart';
import 'package:schedule/src/resources/variables.dart';

class ScheduleSelectorButton extends StatefulWidget {
  final int _tabIndex;

  ScheduleSelectorButton(this._tabIndex);

  @override
  createState() => new ScheduleSelectorButtonState(_tabIndex);
}

class ScheduleSelectorButtonState extends State<ScheduleSelectorButton> {
  int _currentTabIndex = 0;
  String _header;
  List<String> _headers;

  ScheduleSelectorButtonState(this._currentTabIndex) {
    selectorButtonState = this;
    _header = selectorHeaders[_currentTabIndex];
  }

  set tabIndex(int tabIndex) => _currentTabIndex = tabIndex;

  @override
  Widget build(BuildContext context) {
    if (prefs != null) {
      _headers = prefs.getStringList('headers');
      if (_headers != null && _headers[_currentTabIndex].isNotEmpty) {
        _header = prefs.getStringList('headers')[_currentTabIndex];
      } else {
        _header = selectorHeaders[_currentTabIndex];
      }
      return new FlatButton(
        onPressed: () {
          panelController.isPanelOpen ? panelController.close() : panelController.open();
        }, 
        child: new Text(_header, textAlign: TextAlign.center), 
        textColor: Theme.of(context).primaryTextTheme.button.color
      );
    } else {
      return new Text('Загрузка...');
    }
  }
}