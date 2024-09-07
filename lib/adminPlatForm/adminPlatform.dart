import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:first/adminPlatForm/model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CourseAdmin extends StatefulWidget {
  const CourseAdmin({super.key});

  @override
  _CourseAdminState createState() => _CourseAdminState();
}

class _CourseAdminState extends State<CourseAdmin> {
  late Future<List<Course>> futureCourses;

  @override
  void initState() {
    super.initState();
    futureCourses = fetchCourses();
  }

  Future<List<Course>> fetchCourses() async {
    final response = await http.get(
      Uri.parse('$BASE_URL/api/admin/courses'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> coursesJson = jsonResponse['courses'];
      return coursesJson.map((course) => Course.fromJson(course)).toList();
    } else {
      print(response.body);
      throw Exception('Failed to load courses');
    }
  }

  Future<void> activateCourse(String courseId) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/api/admin/courses/$courseId/activate'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      // Successfully activated the course
      print('Course activated successfully');
    } else {
      print(response.body);
      // Failed to activate the course
      throw Exception('Failed to activate course');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Teachers Requests",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: FutureBuilder<List<Course>>(
        future: futureCourses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Course>? courses = snapshot.data;
            return ListView.builder(
              itemCount: courses?.length,
              itemBuilder: (context, index) {
                Course course = courses![index];
                return Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.1,
                        blurRadius: 10,
                        offset: Offset(0, 0.1),
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage("${course.courseImage}"),
                      ),
                      title: Text(
                        "${course.title}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.deepPurple,
                        ),
                      ),
                      subtitle: Text(
                        "Price: \$${course.price}\nDuration: ${course.duration} hours",
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Course Details'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Title: ${course.title}',
                                    style: TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  Text('Description: ${course.description}'),
                                  Text('Price: \$${course.price}'),
                                  Text('Duration: ${course.duration} hours'),
                                  Text('Starting At: ${course.startingAt}'),
                                  Text('Ending At: ${course.endingAt}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Reject',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      await activateCourse("${course.id}");
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Course activated successfully'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => CourseAdmin()),
                                            (Route<dynamic> route) => false, // This removes all the previous routes
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Failed to activate course'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
