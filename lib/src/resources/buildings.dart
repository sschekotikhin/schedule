import 'dart:convert';

import 'package:http/http.dart';
import 'package:schedule/src/models/building.dart';

class Buildings {
  List<Building> _items = [];
  
  Buildings(List<dynamic> items) {
    items.forEach((json) {
      _items.add(new Building(json['Korpus']));
    });
  }

  List<Building> get items => _items;
}

class BuildingsProvider {
  Client client = new Client();

  Future<Buildings> fetch() async {
    final response = await client.get('http://oreluniver.ru/schedule/korpuslist');

    if (response.statusCode == 200) {
      return new Buildings(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      return new Buildings([]);
    }
  }
}