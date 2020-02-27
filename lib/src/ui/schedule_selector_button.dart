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

  ScheduleSelectorButtonState(this._currentTabIndex) {
    selectorButtonState = this;
  }

  set tabIndex(int tabIndex) => _currentTabIndex = tabIndex;

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      onPressed: () {
        panelController.isPanelOpen ? panelController.close() : panelController.open();
      }, 
      child: new Text(selectorHeaders[_currentTabIndex], textAlign: TextAlign.center), 
      textColor: Colors.white
    );
  }
}