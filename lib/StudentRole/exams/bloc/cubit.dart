import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:first/StudentRole/exams/bloc/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExamsStudentCubit extends Cubit<ExamsStudentStatus> {
  ExamsStudentCubit() : super(ExamsStudentInitial());


 late ExamModel examModel;
  Future<ExamModel?> fetchExams() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('$BASE_URL/api/student/exams'),headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      examModel= ExamModel.fromJson(parsedJson);

      emit(ExamsStudentLoaded(examModel!));
    }else {
      print(response.body);
      print("certificate field");
      emit(ExamsStudentError("error"));
      throw Exception('Failed to load profile data');
    }
  }
}
