import 'package:flutter/material.dart';
import 'package:schedule/src/resources/teacher_info_provider.dart';

class TeacherPage extends StatelessWidget {
  final int teacherId;
  final String fullname;

  TeacherPage(this.teacherId, this.fullname);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Преподаватель'),
        title: Text(fullname),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context);})
      ),
      body: FutureBuilder(
        future: TeacgerInfoProvider.getTeacherInfo(teacherId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Widget> positionsWidgets = [];
            for (int i = 0; i < snapshot.data['mainInfo'].length - 2; i++) {
              positionsWidgets.add(Text(snapshot.data['mainInfo'][i]));
            }

            return Center(
              child: ListView(
                children: [
                  Container(
                    // padding: EdgeInsets.only(bottom: 5),
                    margin: EdgeInsets.only(bottom: 5),
                    child: Image.network(
                      snapshot.data['imageUrl'],
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                      // height: MediaQuery.of(context).size.width,
                      // fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                        return CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: MediaQuery.of(context).size.width / 4,
                          child: Icon(
                            Icons.person,
                            size: MediaQuery.of(context).size.width / 2,
                          ),
                        );
                      },
                    )
                  ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.only(left: 0, right: 0, top: 0),
                  //   title: Image.network(
                  //     snapshot.data['imageUrl'],
                  //     width: MediaQuery.of(context).size.width,
                  //     fit: BoxFit.fitWidth,
                  //     loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                  //       if (loadingProgress == null) return child;
                  //       return Center(
                  //         child: CircularProgressIndicator(
                  //           value: loadingProgress.expectedTotalBytes != null
                  //               ? loadingProgress.cumulativeBytesLoaded /
                  //                   loadingProgress.expectedTotalBytes
                  //               : null,
                  //         ),
                  //       );
                  //     },
                  //     errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                  //       return CircleAvatar(
                  //         backgroundColor: Colors.transparent,
                  //         radius: MediaQuery.of(context).size.width / 4,
                  //         child: Icon(
                  //           Icons.person,
                  //           size: MediaQuery.of(context).size.width / 2,
                  //         ),
                  //       );
                  //     },
                  //   )
                  // ),
                  (snapshot.data['mainInfo'][0] != '') ? ListTile(
                    title: Text('Занимаемые должности:'),
                    subtitle: Wrap( children: positionsWidgets)
                  ) : Container(),
                  (snapshot.data['mainInfo'][snapshot.data['mainInfo'].length - 2] != '') ? ListTile(
                    title: Text('Ученая степень: '),
                    subtitle: Text('${snapshot.data['mainInfo'][snapshot.data['mainInfo'].length - 2]}'),
                  ) : Container(),
                  (snapshot.data['mainInfo'][snapshot.data['mainInfo'].length - 1] != '') ? ListTile(
                    title: Text('Ученое звание:'),
                    subtitle: Text('${snapshot.data['mainInfo'][snapshot.data['mainInfo'].length - 1]}'),
                  ) : Container(),
                  (snapshot.data['contacts'][0] != '') ? ListTile(
                    title: Text('Адрес: '),
                    subtitle: Text('${snapshot.data['contacts'][0]}'),
                  ) : Container(),
                  (snapshot.data['contacts'][1] != '') ? ListTile(
                    title: Text('Телефон: '),
                    subtitle: Text('${snapshot.data['contacts'][1]}'),
                  ) : Container(),
                  (snapshot.data['contacts'][2] != '') ? ListTile(
                    title: Text('Почта: '),
                    subtitle: Text('${snapshot.data['contacts'][2]}'),
                  ) : Container(),
                  // Text('Занимаемые должности: ${snapshot.data['mainInfo'][0]}'),
                  // Text('Ученая степень: ${snapshot.data['mainInfo'][1]}'),
                  // Text('Ученое звание: ${snapshot.data['mainInfo'][2]}'),
                  // Text('Адрес: ${snapshot.data['contacts'][0]}'),
                  // Text('Телефон: ${snapshot.data['contacts'][1]}'),
                  // Text('Почта: ${snapshot.data['contacts'][2]}'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Не удалось загрузить данные!'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }
}