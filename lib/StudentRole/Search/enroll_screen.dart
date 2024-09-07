import 'dart:convert';

import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:first/StudentRole/Search/bloc/searchCourseModel.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class EnrollScreen extends StatelessWidget {
  const EnrollScreen({super.key, required this.courseStudent});
final CourseStudent courseStudent;


  Future<bool> enrollInCourse(int courseId) async {
    final String apiUrl = '$BASE_URL/api/student/courses/$courseId/register'; // Replace with your actual API endpoint


    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
        },

      );

      if (response.statusCode == 200) {
        // Enrollment successful
        print(response.body);
        return true;
      } else {
        // Enrollment failed
        print(response.body);
        print('Failed to enroll in course: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error occurred during enrollment: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage('${courseStudent.courseImage}'), // Replace this with your image path
            ),
            SizedBox(height: 20),
            Text(
              'Title: ${courseStudent.courseTitle}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'price: \$${courseStudent.price}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Description: ${courseStudent.description}',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Start Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('${courseStudent.startingAt}'),
                  ],
                ),
                SizedBox(width: 40),
                Column(
                  children: [
                    Text(
                      'End Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('${courseStudent.endingAt}'),

                  ],
                ),

              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool success = await enrollInCourse(courseStudent.id!);
                if (success) {
                  // Show success message or navigate to another screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Enrolled successfully')),
                  );
                } else {
                  // Show failure message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('you are already registered before')),
                  );
                }
              },
              child: Text('Enroll',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
            ),
          ],
        ),
      ),
    );
  }
}
