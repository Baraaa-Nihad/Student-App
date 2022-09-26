import 'package:eschool/data/models/academicYear.dart';

class AppConfiguration {
  AppConfiguration({
    required this.appLink,
    required this.iosAppLink,
    required this.appVersion,
    required this.iosAppVersion,
    required this.forceAppUpdate,
    required this.appMaintenance,
  });
  late final String appLink;
  late final String iosAppLink;
  late final String appVersion;
  late final String iosAppVersion;
  late final String forceAppUpdate;
  late final String appMaintenance;
  late final AcademicYear academicYear;
  late final String schoolName;
  late final String schoolTagline;

  AppConfiguration.fromJson(Map<String, dynamic> json) {
    appLink = json['app_link'] ?? "";
    iosAppLink = json['ios_app_link'] ?? "";
    appVersion = json['app_version'] ?? "";
    iosAppVersion = json['ios_app_version'] ?? "";
    forceAppUpdate = json['force_app_update'] ?? "0";
    appMaintenance = json['app_maintenance'] ?? "0";
    schoolName = json['school_name'] ?? "";
    schoolTagline = json['school_tagline'] ?? "";
    academicYear = AcademicYear.fromJson(json['session_year'] ?? {});
  }
}
