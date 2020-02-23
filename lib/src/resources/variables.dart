import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum selectorMode {
  division,
  course,
  group
}

BorderRadius slidingPanelRadius = new BorderRadius.only(
  bottomLeft: Radius.circular(24.0),
  bottomRight: Radius.circular(24.0)
);

PanelController panelController = new PanelController(); 

int defaultScheduleMod = 1;