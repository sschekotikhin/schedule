import 'package:flutter/material.dart';

import 'package:schedule/src/resources/variables.dart';
import 'package:schedule/src/blocs/bloc.dart';

import 'package:schedule/src/ui/exams_schedule/exams_list_view.dart';

class ExamsTabBarView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ExamsTabBarViewState();
}

class ExamsTabBarViewState extends State<ExamsTabBarView> {
  ExamsTabBarViewState() {
    tabBarViewState = this;
  }

  @override
  Widget build(BuildContext context) {
    Bloc bloc = new Bloc.exams(scheduleMode);
    bloc.fetch();

    return new StreamBuilder(
      stream: bloc.data,
      builder: (context, AsyncSnapshot snapshot) {
        print(snapshot.data);
        return TabBarView(
          children: [
            ExamsListView(examType.test, snapshot),
            ExamsListView(examType.exam, snapshot),
            ExamsListView(examType.other, snapshot)
          ]
        );
      }
    );
  }
}

class ExamsTabBar extends StatelessWidget with PreferredSizeWidget{
  Size get preferredSize => new Size.fromHeight(50.0);
  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(child: Text('Зачеты')),
        Tab(child: Text('Экзамены')),
        Tab(child: Text('Другое')),
      ]
    );
  }
}