import 'package:eschool/data/models/subjectMark.dart';

class Result {
  Result(
      {required this.id,
      required this.name,
      required this.description,
      required this.classId,
      required this.sessionYearId,
      required this.publish,
      required this.grade,
      required this.obtainedMark,
      required this.percentage,
      required this.subjectMarks,
      required this.totalMark});
  late final int id;
  late final List<SubjectMark> subjectMarks;
  late final String name;
  late final String description;
  late final int classId;
  late final int sessionYearId;
  late final int publish;
  late final int totalMark;
  late final int obtainedMark;
  late final double percentage;
  late final String grade;

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    subjectMarks = ((json['marks'] ?? []) as List)
        .map((subjectMark) => SubjectMark.fromJson(Map.from(subjectMark)))
        .toList();
    description = json['description'] ?? "";
    classId = json['class_id'] ?? 0;
    sessionYearId = json['session_year_id'] ?? 0;
    publish = json['publish'] ?? -1;
    totalMark = json['result'] == null ? 0 : json['result']['total_marks'] ?? 0;
    obtainedMark =
        json['result'] == null ? 0 : json['result']['obtained_marks'] ?? 0;
    percentage = json['result'] == null
        ? 0.0
        : double.parse((json['result']['percentage'] ?? 0).toString());
    grade = json['result'] == null ? "" : json['result']['grade'] ?? "";
  }
}
