import 'package:flutter/material.dart';
import 'package:schedule/src/resources/variables.dart';

class ScheduleSelectorButton extends StatefulWidget {
  final int _tabIndex;

  ScheduleSelectorButton(this._tabIndex);

  static String getHeader(tabIndex) {
    List<String> headers = prefs.getStringList('headers');
      if (headers != null && headers[tabIndex].isNotEmpty) {
        return prefs.getStringList('headers')[tabIndex];
      } else {
        return selectorHeaders[tabIndex];
      }
  }

  @override
  createState() => new ScheduleSelectorButtonState(_tabIndex);
}

class ScheduleSelectorButtonState extends State<ScheduleSelectorButton> {
  int _currentTabIndex = 0;
  String _header;

  ScheduleSelectorButtonState(this._currentTabIndex) {
    selectorButtonState = this;
    _header = selectorHeaders[_currentTabIndex];
  }

  set tabIndex(int tabIndex) => _currentTabIndex = tabIndex;

  @override
  Widget build(BuildContext context) {
    if (prefs != null) {
      _header = ScheduleSelectorButton.getHeader(_currentTabIndex);
      return new FlatButton(
        onPressed: savedScheduleMode ? null : () {
          panelController.isPanelOpen ? panelController.close() : panelController.open();
        }, 
        child: new Text(_header, textAlign: TextAlign.center), 
        textColor: Theme.of(context).primaryTextTheme.button.color,
        disabledTextColor: Theme.of(context).primaryTextTheme.button.color,
      );
    } else {
      return new Text('Загрузка...');
    }
  }
}