import 'package:eschool/data/models/subject.dart';

class SubjectMark {
  final Subject subject;
  final int totalMarks;
  final int obtainedMarks;
  final String grade;
  final int passingStatus;
  final int passingMarks;
  final DateTime examDate;

  SubjectMark(
      {required this.grade,
      required this.examDate,
      required this.passingStatus,
      required this.obtainedMarks,
      required this.subject,
      required this.passingMarks,
      required this.totalMarks});

  static SubjectMark fromJson(Map<String, dynamic> json) {
    return SubjectMark(
        grade: json['grade'] ?? "",
        obtainedMarks: json['obtained_marks'] ?? 0,
        subject: Subject.fromJson(Map.from(json['subject'] ?? {})),
        passingStatus: json['passing_status'] ?? -1,
        passingMarks: json['timetable'] == null
            ? 0
            : json['timetable']['passing_marks'] ?? 0,
        examDate: json['timetable'] == null
            ? DateTime.now()
            : json['timetable']['date'] == null
                ? DateTime.now()
                : DateTime.parse(json['timetable']['date']),
        totalMarks: json['timetable'] == null
            ? 0
            : json['timetable']['total_marks'] ?? 0);
  }
}
