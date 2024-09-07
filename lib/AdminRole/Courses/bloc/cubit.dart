import 'dart:convert';



import 'package:first/AdminRole/Courses/bloc/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Const/end_point.dart';
import '../../../Const/shared_prefirance.dart';
import 'package:http/http.dart'as http;




class CoursesCubit extends Cubit<CoursesStatus>{
  CoursesCubit():super(CoursesInitialized());

  CourseModelTeacher? courseModelTeacher;

  Future<CourseModelTeacher?> getCoursesTeacher() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('$BASE_URL/api/teacher/courses'),headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      courseModelTeacher= CourseModelTeacher.fromJson(parsedJson);
      print(courseModelTeacher!);
      emit(CoursesSuccess(courseModelTeacher!));
    }else {
      print("certificate field");
      emit(CoursesError());
      throw Exception('Failed to load profile data');
    }
  }


  Future<void> deleteCourse(int courseId ) async {
    final url = Uri.parse('$BASE_URL/api/teacher/courses/$courseId');
    final response = await http.delete(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete course');
    }
  }
}