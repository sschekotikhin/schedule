class Teacher {
  int _id;
  String _lastName;
  String _firstName;
  String _middleName;
  String _fullName;

  Teacher(this._id, this._lastName, this._firstName, this._middleName, this._fullName);

  String get lastName => _lastName;
  
  String get firstName => _firstName;

  String get middleName => _middleName;

  String get fullName => _fullName;

  int get id => _id;
}