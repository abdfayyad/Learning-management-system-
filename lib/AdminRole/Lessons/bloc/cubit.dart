import 'dart:convert';

import 'package:first/AdminRole/Lessons/bloc/status.dart';
import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
class LessonsCubit extends Cubit<LessonsStatus>{
  LessonsCubit():super(LessonsInitialized());
  LessonModelTeacher ?lessonModelTeacher;
  Future<LessonModelTeacher?> getLessonsTeacher() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('${BASE_URL}/api/teacher/lessons'),headers: headers);
print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      lessonModelTeacher= LessonModelTeacher.fromJson(parsedJson);
      print(lessonModelTeacher!);
      emit(LessonsSuccess(lessonModelTeacher!));
    }else {
      print("certificate field");
      emit(LessonsError());
      throw Exception('Failed to load profile data');
    }
  }
}