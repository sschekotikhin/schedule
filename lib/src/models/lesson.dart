class Lesson {
  int _id;
  int _subGroupNumber;
  String _subjectTitle;
  String _lessonType;
  int _lessonNumber;
  int _weekDay;
  String _housing;
  String _roomNumber;
  String _special;
  String _title;
  int _employeeId;
  String _lastName;
  String _firstName;
  String _midName;
  String _fullName;

  Lesson(this._id, this._subGroupNumber, this._subjectTitle,
         this._lessonType, this._lessonNumber, this._weekDay,
         this._housing, this._roomNumber, this._special,
         this._title, this._employeeId, this._lastName,
        this._firstName, this._midName) {
          if (_lastName.isNotEmpty && _firstName.isNotEmpty && _midName.isNotEmpty) {
            _fullName = '$_lastName ${_firstName[0]}.${_midName[0]}.';
          } else {
            _fullName = '';
          }
        }

  int get id => _id;
  int get subGroupNumber => _subGroupNumber;
  int get lessonNumber => _lessonNumber;
  int get weekDay => _weekDay;
  String get housing => _housing;
  int get employyeId => _employeeId;

  String get subjectTitle => _subjectTitle;
  String get lessonType => _lessonType;
  String get roomNumber => _roomNumber;
  String get special => _special;
  String get title => _title;
  String get lastName => _lastName;
  String get firstName => _firstName;
  String get midName => _midName;
  String get fullName => _fullName;

  //set setFullName(String fullname) => _fullName = fullName;
  set setTitle(String title) => _title = title;

  void setFullName(String fullname) {
    _fullName = fullName;
  }

  static List<Lesson> lessonsByDay(int day, List<Lesson> lessons) {
    List<Lesson> collection = lessons.where((lesson) {
      return lesson.weekDay == day;
    }).toList();

    collection.sort((l1, l2) => l1.lessonNumber.compareTo(l2.lessonNumber));
  
    return collection;
  }

  static Lesson collapseLessons(List<Lesson> lessons) {
    String fullName = '';
    lessons.forEach((lesson) {
      fullName += lesson.fullName + ', ';
    });

    if (fullName.isEmpty) {
      return null;
    } else {
      Lesson temp = lessons[0];
      temp.setFullName(fullName);
      return temp;
    }
  }

  static List<Lesson> lessonsByNumber(int number, List<Lesson> lessons) {
    List<Lesson> collection = lessons.where((lesson) {
      return lesson.lessonNumber == number;
    }).toList();

    return collection;
  }
}
