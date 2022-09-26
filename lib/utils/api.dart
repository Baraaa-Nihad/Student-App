import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eschool/utils/constants.dart';
import 'package:eschool/utils/errorMessageKeysAndCodes.dart';
import 'package:eschool/utils/hiveBoxKeys.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ApiException implements Exception {
  String errorMessage;

  ApiException(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}

class Api {
  static Map<String, dynamic> headers() {
    final String jwtToken = Hive.box(authBoxKey).get(jwtTokenKey) ?? "";

    return {"Authorization": "Bearer $jwtToken"};
  }

  //
  //Student app apis
  //
  static String studentLogin = "${databaseUrl}student/login";
  static String studentSubjects = "${databaseUrl}student/subjects";
  //get subjects of given class
  static String classSubjects = "${databaseUrl}student/class-subjects";
  static String studentTimeTable = "${databaseUrl}student/timetable";
  static String selectStudentElectiveSubjects =
      "${databaseUrl}student/select-subjects";
  static String getLessonsOfSubject = "${databaseUrl}student/lessons";
  static String getstudyMaterialsOfTopic =
      "${databaseUrl}student/lesson-topics";
  static String getStudentAttendance = "${databaseUrl}student/attendance";
  static String getAssignments = "${databaseUrl}student/assignments";
  static String submitAssignment = "${databaseUrl}student/submit-assignment";
  static String generalAnnouncements = "${databaseUrl}student/announcements";
  static String parentDetailsOfStudent = "${databaseUrl}student/parent-details";
  static String deleteAssignment =
      "${databaseUrl}student/delete-assignment-submission";

  static String studentResults = "${databaseUrl}student/exam-result";
  static String requestResetPassword = "${databaseUrl}student/forgot-password";

  //
  //Apis that will be use in both student and parent app
  //
  static String getSliders = "${databaseUrl}sliders";
  static String logout = "${databaseUrl}logout";
  static String settings = "${databaseUrl}settings";
  static String holidays = "${databaseUrl}holidays";

  static String changePassword = "${databaseUrl}change-password";

  //
  //Parent app apis
  //
  static String subjectsByChildId = "${databaseUrl}parent/subjects";
  static String parentLogin = "${databaseUrl}parent/login";
  static String lessonsOfSubjectParent = "${databaseUrl}parent/lessons";
  static String getstudyMaterialsOfTopicParent =
      "${databaseUrl}parent/lesson-topics";
  static String getAssignmentsParent = "${databaseUrl}parent/assignments";
  static String getStudentAttendanceParent = "${databaseUrl}parent/attendance";
  static String getStudentTimetableParent = "${databaseUrl}parent/timetable";
  static String getStudentResultsParent = "${databaseUrl}parent/exam-result";
  static String generalAnnouncementsParent =
      "${databaseUrl}parent/announcements";

  static String getStudentTeachersParent = "${databaseUrl}parent/teachers";
  static String forgotPassword = "${databaseUrl}forgot-password";

  static Future<Map<String, dynamic>> post({
    required Map<String, dynamic> body,
    required String url,
    required bool useAuthToken,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final Dio dio = Dio();
      final FormData formData =
          FormData.fromMap(body, ListFormat.multiCompatible);

      final response = await dio.post(url,
          data: formData,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          options: useAuthToken ? Options(headers: headers()) : null);

      if (response.data['error']) {
        print(response.data);
        throw ApiException(response.data['code'].toString());
      }
      return Map.from(response.data);
    } on DioError catch (e) {
      print(e.toString());
      throw ApiException(e.error is SocketException
          ? ErrorMessageKeysAndCode.noInternetCode
          : ErrorMessageKeysAndCode.defaultErrorMessageCode);
    } on ApiException catch (e) {
      throw ApiException(e.errorMessage);
    } catch (e) {
      print(e.toString());
      throw ApiException(ErrorMessageKeysAndCode.defaultErrorMessageKey);
    }
  }

  static Future<Map<String, dynamic>> get({
    required String url,
    required bool useAuthToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      //
      final Dio dio = Dio();
      final response = await dio.get(url,
          queryParameters: queryParameters,
          options: useAuthToken ? Options(headers: headers()) : null);

      if (response.data['error']) {
        throw ApiException(response.data['code'].toString());
      }

      return Map.from(response.data);
    } on DioError catch (e) {
      throw ApiException(e.error is SocketException
          ? ErrorMessageKeysAndCode.noInternetCode
          : ErrorMessageKeysAndCode.defaultErrorMessageCode);
    } on ApiException catch (e) {
      throw ApiException(e.errorMessage);
    } catch (e) {
      throw ApiException(ErrorMessageKeysAndCode.defaultErrorMessageKey);
    }
  }

  static Future<void> download(
      {required String url,
      required CancelToken cancelToken,
      required String savePath,
      required Function updateDownloadedPercentage}) async {
    try {
      final Dio dio = Dio();
      await dio.download(url, savePath, cancelToken: cancelToken,
          onReceiveProgress: ((count, total) {
        updateDownloadedPercentage((count / total) * 100);
      }));
    } on DioError catch (e) {
      throw ApiException(e.error is SocketException
          ? ErrorMessageKeysAndCode.noInternetCode
          : ErrorMessageKeysAndCode.defaultErrorMessageCode);
    } on ApiException catch (e) {
      throw ApiException(e.errorMessage);
    } catch (e) {
      throw ApiException(ErrorMessageKeysAndCode.defaultErrorMessageKey);
    }
  }
}
