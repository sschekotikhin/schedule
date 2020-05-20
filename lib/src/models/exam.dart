import 'package:schedule/src/resources/variables.dart';

class Exam {
  String _dbDate;
  String _date;
  String _time;
  int _weekDay;
  String _group;
  String _subjectTitle;
  String _lessonType;
  String _roomNumber;
  int _employeeId;
  String _lastName;
  String _firstName;
  String _midName;
  String _fullName;

  Exam(this._dbDate, this._date, this._time,
         this._weekDay, this._group, this._subjectTitle,
         this._lessonType, this._roomNumber, this._employeeId,
         this._lastName, this._firstName, this._midName) {
          if (_lastName.isNotEmpty && _firstName.isNotEmpty && _midName.isNotEmpty) {
            _fullName = '$_lastName ${_firstName[0]}.${_midName[0]}.';
          } else {
            _fullName = '';
          }
        }

  String get dbDate => _dbDate;
  String get date =>_date;
  String get time => _time;
  int get weekDay => _weekDay;
  String get group => _group;
  String get subjectTitle => _subjectTitle;
  String get lessonType => _lessonType;
  String get roomNumber => _roomNumber;
  int get employeeId => _employeeId;
  String get lastName => _lastName;
  String get firstName => _firstName;
  String get midName => _midName;
  String get fullName => _fullName;
 
  set setFullName(String fullname) => _fullName = fullName;

  static List<Exam> examsByType(examType type, List<Exam> exams) {
    List<Exam> collection;

    switch (type) {
      case examType.exam:
        collection = exams.where((exam) =>
          exam.lessonType == 'экзамен' || exam.lessonType == 'консультация'
        ).toList();
      break;
        
      case examType.test:
        collection = exams.where((exam) =>
          exam.lessonType == 'зачет'
        ).toList();
      break;

      case examType.other:
        collection = exams.where((exam) =>
          exam.lessonType != 'экзамен' && exam.lessonType != 'консультация' && exam.lessonType != 'зачет'
        ).toList();
      break;
    }

    // collection.sort((l1, l2) => l1.lessonNumber.compareTo(l2.lessonNumber));
  
    return collection;
  }
}
