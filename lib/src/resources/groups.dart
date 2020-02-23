import 'dart:convert';

import 'package:http/http.dart';
import 'package:schedule/src/models/group.dart';

class Groups {
  List<Group> _items = [];

  Groups(List<dynamic> items) {
    items.forEach((json) {
      _items.add(new Group(json['idGruop'], json['Codedirection'], json['levelEducation'], json['title']));
    });
  }
}

class GroupsProvider {
  int _directionId;
  int _course;

  Client client = new Client();

  Future<Groups> fetchGroups() async {
    final response = await client.get('http://oreluniver.ru/schedule/$_directionId/$_course/grouplist');

    if (response.statusCode == 200) {
      return new Groups(json.decode(json.encode(response.bodyBytes)));
    } else {
      return Groups([]);
    }
  }
}
