import 'package:flutter/material.dart';
import 'package:schedule/src/blocs/divisions_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final DivisionsBloc bloc = new DivisionsBloc();

BorderRadius slidingPanelRadius = new BorderRadius.only(
  bottomLeft: Radius.circular(24.0),
  bottomRight: Radius.circular(24.0)
);

PanelController panelController = new PanelController(); 

int defaultScheduleMod = 1;