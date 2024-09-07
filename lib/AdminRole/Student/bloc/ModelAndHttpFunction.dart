import 'dart:convert';
import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:http/http.dart' as http;

class Student {
  final String name;
  final String email;
  final String photoUrl;

  Student({required this.name, required this.email, required this.photoUrl});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      email: json['email'],
      photoUrl: json['image'],
    );
  }
}

Future<List<Student>> fetchStudents() async {
  final response = await http.get(Uri.parse('$BASE_URL/api/teacher/all_students'),headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
  },);
  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    print(jsonData);
    return jsonData.map((json) => Student.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load students');
  }
}
