import 'dart:convert';

import 'package:first/AdminRole/exams/bloc/status.dart';
import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
class ExamsCubit extends Cubit<ExamsStatus>{
  ExamsCubit():super(ExamsInitialized());
late ExamModel examModel;
  Future<ExamModel?> getExams() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('${BASE_URL}/api/teacher/exams'),headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      examModel= ExamModel.fromJson(parsedJson);
      emit(ExamsSuccess(examModel));
    }else {
      print("certificate field");
      emit(ExamsError());
      throw Exception('Failed to load profile data');
    }
  }
}