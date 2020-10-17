import 'package:flutter/material.dart';

import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/ui/schedule_selector_button.dart';

import 'lessons_distribution_page.dart';

class LDAppBar extends StatefulWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(50.0);

  LDAppBarState createState() => LDAppBarState();
}

class LDAppBarState extends State<LDAppBar> {
  Widget buildModeSelectorItem(int value) => Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(modeIcons[value], color: Theme.of(context).iconTheme.color),
      Padding(padding: EdgeInsets.only(left: 10) , child: Text(modeLabels[value]))
    ]
  );

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      title: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new ScheduleSelectorButton(scheduleMode)
          )
        ]
      ),
      actions: <Widget>[
        // new IconButton(icon: new Icon(null), onPressed: null),
        IconButton(
          icon: Icon(Icons.refresh),
          tooltip: 'Обновить', 
          onPressed: (){
            tabBarViewState.setState(() {});
          }
        ),
        PopupMenuButton<int>(
          icon: Icon(modeIcons[scheduleMode]),
          tooltip: 'Выбрать режим',
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: buildModeSelectorItem(0),
              value: 0,
            ),
            PopupMenuItem(
              child: buildModeSelectorItem(1),
              value: 1,
            ),
            // PopupMenuItem(
            //   child: buildModeSelectorItem(2),
            //   value: 2,
            // )
          ],
          onSelected: (value) {
            setState(() {
              scheduleMode = value;

              tabBarViewState.setState(() {});

              scheduleSelectorState.setState(() {
                scheduleSelectorState.tabIndex = value;
                scheduleSelectorState.stateIndex = lastSelectorStates[value];
              });

              selectorButtonState.setState(() {
                selectorButtonState.tabIndex = value;
              });

              prefs.setInt('schedule_mode', value);
            });
          },
        ),
      ]
    );
  }
}