class Group {
  int _id;
  String _title;
  String _directionCode;
  String _educationLevel;

  Group(this._id, this._directionCode, this._educationLevel, this._title);

  int get id => _id;

  String get title => _title;

  String get directionCode => _directionCode;

  String get educationLevel => _educationLevel;
}
