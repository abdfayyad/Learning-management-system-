import 'dart:convert';

import 'package:first/Const/end_point.dart';
import 'package:first/StudentRole/Lessons/bloc/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
import '../../../Const/shared_prefirance.dart';

class LessonsStudentCubit extends Cubit<LessonsStudentStatus>{
  LessonsStudentCubit():super(LessonsInitialized());
  LessonModelStudent ?lessonModelStudent;
  Future<LessonModelStudent?> getLessonsStudent() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('$BASE_URL/api/student/lessons'), headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final List<dynamic> parsedJson = jsonDecode(response.body);
      lessonModelStudent = LessonModelStudent.fromJson(parsedJson);
      print(lessonModelStudent!);
      emit(LessonsSuccess(lessonModelStudent!));
    } else {
      print(response.body);
      print("certificate field");
      emit(LessonsError());
      throw Exception('Failed to load profile data');
    }
  }

}