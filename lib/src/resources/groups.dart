import 'dart:convert';

import 'package:http/http.dart';
import 'package:schedule/src/models/group.dart';

class Groups {
  List<Group> _items = [];

  Groups(List<dynamic> items) {
    items.forEach((json) {
      _items.add(new Group(json['idgruop'], json['Codedirection'], json['levelEducation'], json['title']));
    });
  }

  List<Group> get items => _items;
}

class GroupsProvider {
  int _directionId;
  int _course;

  GroupsProvider(this._directionId, this._course);

  Client client = new Client();

  Future<Groups> fetch() async {
    final response = await client.get('http://oreluniver.ru/schedule/$_directionId/$_course/grouplist');

    if (response.statusCode == 200) {
      return new Groups(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      return Groups([]);
    }
  }
}
