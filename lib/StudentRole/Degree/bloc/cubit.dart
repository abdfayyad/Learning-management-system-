import 'dart:convert';

import 'package:first/Const/shared_prefirance.dart';
import 'package:first/StudentRole/Degree/bloc/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;

import '../../../Const/end_point.dart';
class DegreeCubit extends Cubit<DegreeStatus>{
  DegreeCubit():super(DegreeInitialized());
late DegreeModel degreeModel;
  Future<DegreeModel?> getDegreeStudent() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('$BASE_URL/api/student/marks'),headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      degreeModel= DegreeModel.fromJson(parsedJson);
      print(degreeModel);
      emit(DegreeSuccess(degreeModel));
    }else {
      print(" field");
      emit(DegreeError());
      throw Exception('Failed to load  data');
    }
  }
}