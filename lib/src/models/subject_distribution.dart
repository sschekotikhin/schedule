class SubjectTypeDistribution {
  String _type;
  int _lessonsCount;
  Map _distribution;
  
  String get type => _type;
  int get lessonsCount => _lessonsCount;
  Map get distribution => _distribution;

  SubjectTypeDistribution(this._type, this._lessonsCount, this._distribution);
}

class SubjectDistribution {
  String _title;
  List<SubjectTypeDistribution> _subjectTypesDistribution;


  String get title => _title;
  List<SubjectTypeDistribution> get subjectTypesDistribution => _subjectTypesDistribution;

  SubjectDistribution(this._title, this._subjectTypesDistribution);

  static List<SubjectDistribution> collapseSubjects(List<SubjectDistribution> subjects) {
    List<SubjectDistribution> items = [];
    while (subjects.isNotEmpty) {
      List<SubjectTypeDistribution> tmp = [];
      subjects.where((element) => element._title == subjects[0]._title).forEach((element) {
        tmp.add(element._subjectTypesDistribution[0]);
      });

      items.add(SubjectDistribution(subjects[0]._title, tmp));

      subjects.removeWhere((element) => element._title == subjects[0]._title);
    }

    return items;
  }
}