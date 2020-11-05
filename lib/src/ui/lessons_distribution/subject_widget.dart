import 'package:flutter/material.dart';
import 'package:schedule/src/models/subject_distribution.dart';

class SubjectWidget extends StatelessWidget {
  final SubjectDistribution _subject;
  final int _startWeek;
  final int _endWeek;

  SubjectWidget(this._subject, this._startWeek, this._endWeek);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    TextAlign textAlign = TextAlign.center;

    // List<DataColumn> columns = [
    //   DataColumn(label: Text('Тип', style: textStyle)),
    // ];
    // for (var i = _startWeek; i <= _endWeek; i++) {
    //   columns.add(
    //     DataColumn(label: Text('$i', style: textStyle))
    //   );
    // }

    // List<DataRow> rows = [];
    // _subject.subjectTypesDistribution.forEach((typeDistribution) {
    //   List<DataCell> cells = [
    //     DataCell(Text('${typeDistribution.type} (${typeDistribution.lessonsCount})', style: textStyle))
    //   ];

    //   for (var i = _startWeek; i <= _endWeek; i++) {
    //     cells.add(
    //       (typeDistribution.distribution['$i'] != null) ?
    //       DataCell(Text('${typeDistribution.distribution['$i']}', style: textStyle)) :
    //       DataCell.empty
    //     );
    //   }

    //   rows.add(
    //     DataRow(
    //       cells: cells
    //     )
    //   );
    // });



    List<Container> headerRow = [
      Container(
        padding: EdgeInsets.all(10),
        child: Text('Тип', style: textStyle, textAlign: textAlign,)
      )
    ];
    for (var i = _startWeek; i <= _endWeek; i++) {
      headerRow.add(
        Container(
          padding: EdgeInsets.all(10),
          child: Text('$i', style: textStyle, textAlign: textAlign,)
        )
      );
    }

    List<TableRow> tableChildren = [
      TableRow(children: headerRow)
    ];

    _subject.subjectTypesDistribution.forEach((typeDistribution) {
      List<Container> rowChildren = [
        Container(
          padding: EdgeInsets.all(10),
          child: Text('${typeDistribution.type} (${typeDistribution.lessonsCount})', style: textStyle)
        )
      ];

      for (var i = _startWeek; i <= _endWeek; i++) {
        rowChildren.add(
          Container(
            padding: EdgeInsets.all(10),
            child: (typeDistribution.distribution['$i'] != null) ?
            Text('${typeDistribution.distribution['$i']}', style: textStyle, textAlign: textAlign,) :
            Text('')
          )
        );
      }

      tableChildren.add(TableRow(children: rowChildren));
    });

    return ExpansionTile(
      title: Text(_subject.title),
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // child: DataTable(
          //   horizontalMargin: 15,
          //   columnSpacing: 40,
          //   columns: columns, 
          //   rows: rows
          // ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  defaultColumnWidth: FixedColumnWidth(40),
                  columnWidths: {
                    0: IntrinsicColumnWidth()
                  },
                  border: TableBorder.all(),
                  children:tableChildren
                    
                ),
              )
            ],
          )
          
        
        )
      ],
    );
  }
}