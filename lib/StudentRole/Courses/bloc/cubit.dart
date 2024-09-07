import 'dart:convert';

import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:first/StudentRole/Courses/bloc/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
class CoursesStudentCubit extends Cubit<CoursesStudentStatus>{
  CoursesStudentCubit():super(CoursesInitialized());
  CourseModelStudent? courseModelStudent;

  Future<CourseModelStudent?> getCoursesStudent() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('$BASE_URL/api/student/courses/enrolled'),headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      courseModelStudent= CourseModelStudent.fromJson(parsedJson);
      print(courseModelStudent!);
      emit(CoursesSuccess(courseModelStudent!));
    }else {
      print(response.body);
      print("certificate field");
      emit(CoursesError());
      throw Exception('Failed to load profile data');
    }
  }
}