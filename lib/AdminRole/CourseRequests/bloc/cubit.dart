import 'dart:convert';

import 'package:first/AdminRole/CourseRequests/bloc/status.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;

import '../../../Const/end_point.dart';
class CourseRequestCubit extends Cubit<CourseRequestStatus>{
  CourseRequestCubit():super(CourseRequestInitialized());


  CourseRequestsModel? courseRequestsModel;

  Future<CourseRequestsModel?> getCoursesRequests() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('${BASE_URL}/api/teacher/Courses'),headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      courseRequestsModel= CourseRequestsModel.fromJson(parsedJson);
      print(courseRequestsModel!);
      emit(CourseRequestSuccess(courseRequestsModel!));
    }else {
      print("certificate field");
      emit(CourseRequestError());
      throw Exception('Failed to load profile data');
    }
  }
}