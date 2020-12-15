import 'package:flutter/material.dart';
import 'package:schedule/src/app.dart';
import 'package:schedule/src/background_worker/background_work_manager.dart';

// void main() => runApp(App());

void main() {
  BackgroundWorkManager.initWorkManager();
  runApp(App());
}
