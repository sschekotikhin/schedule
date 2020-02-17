class Division {
  int _id;
  String _title;
  String _shortTitle;

  Division(this._id, this._title, this._shortTitle);

  String get title => _title;
  
  String get shortTitle => _shortTitle;

  int get id => _id;
}