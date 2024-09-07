import 'dart:convert';
import 'package:first/AdminRole/Profile/bloc/status.dart';
import 'package:first/Const/end_point.dart';
import 'package:http/http.dart' as http;

import '../../../Const/shared_prefirance.dart';
class ProfileService {
  Future<ProfileModel> getProfile() async {
    final response = await http.get(
      Uri.parse('$BASE_URL/api/teacher/profile'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ProfileModel.fromJson(json.decode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to load profile');
    }
  }
  Future<void> updateProfile(String newName, String newPhone, String newEmail) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/api/teacher/profile/edit'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      },
      body: jsonEncode(<String, String>{
        'name': newName,
        'phone': newPhone,
        'email': newEmail,
      }),
    );

    print(response.body);

    if (response.statusCode != 200) {
      print(response.body);
      throw Exception('Failed to update profile');
    } else {
      print(response.body);
    }
  }


  Future<void> changePassword(String oldPassword, String newPassword) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/api/teacher/profile/change_password'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      },
      body: jsonEncode(<String, String>{
        'old_password': oldPassword,
        'new_password': newPassword,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to change password');
    }
  }
}
