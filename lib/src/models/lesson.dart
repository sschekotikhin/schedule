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

  Lesson(this._id, this._subGroupNumber, this._subjectTitle,
         this._lessonType, this._lessonNumber, this._weekDay,
         this._housing, this._roomNumber, this._special,
         this._title, this._employeeId, this._lastName,
        this._firstName, this._midName);

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

  static List<Lesson> lessonsByDay(int day, List<Lesson> lessons) {
    List<Lesson> collection = lessons.where((lesson) {
      return lesson.weekDay == day;
    }).toList();

    collection.sort((l1, l2) => l1.lessonNumber.compareTo(l2.lessonNumber));
  
    return collection;
  }
}
