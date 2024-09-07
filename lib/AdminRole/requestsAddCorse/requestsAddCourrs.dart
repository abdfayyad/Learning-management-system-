import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestAddCourse extends StatefulWidget {
  const RequestAddCourse({super.key});

  @override
  _RequestAddCourseState createState() => _RequestAddCourseState();
}

class _RequestAddCourseState extends State<RequestAddCourse> {
  late Future<List<RequestModel>> _courses;

  @override
  void initState() {
    super.initState();
    _courses = fetchCourses();
  }

  Future<List<RequestModel>> fetchCourses() async {
    final response = await http.get(
      Uri.parse('$BASE_URL/api/teacher/courses/pending'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<RequestModel> courses = body.map((dynamic item) => RequestModel.fromJson(item)).toList();
      return courses;
    } else {
      throw Exception('Failed to load courses');
    }
  }



  void _showDeleteDialog(BuildContext context, int courseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to cancel adding this course?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text("Cancel"),
            ),
            // TextButton(
            //   onPressed: () {
            //   //   deleteCourse(courseId).then((_) {
            //   //     Navigator.of(context).pop(); // Dismiss the dialog
            //   //     setState(() {
            //   //       _courses = fetchCourses(); // Refresh the course list
            //   //     });
            //   //   }).catchError((error) {
            //   //     Navigator.of(context).pop(); // Dismiss the dialog
            //   //     ScaffoldMessenger.of(context).showSnackBar(
            //   //       SnackBar(content: Text('Failed to delete course')),
            //   //     );
            //   //   });
            //   // },
            //   child: const Text("Delete"),
            // ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Courses Request",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: FutureBuilder<List<RequestModel>>(
        future: _courses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No courses found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                RequestModel course = snapshot.data![index];
                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.1,
                        blurRadius: 10,
                        offset: const Offset(0, 0.1),
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      leading: Container(
                        width: 80,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(course.courseImage ?? ""),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      title: Text(
                        course.courseTitle ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Price: ${course.price ?? ""}"),
                          Text("Date Started: ${course.startingAt ?? ""}"),
                          Text("Date Finished: ${course.endingAt ?? ""}"),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteDialog(context, course.id!);
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

}
class RequestModel {
  int? id;
  String? courseTitle;
  String? description;
  String? price;
  String? courseImage;
  String? startingAt;
  String? endingAt;
  int? duration;
  int? isActive;
  String? averageRating;

  RequestModel(
      {this.id,
        this.courseTitle,
        this.description,
        this.price,
        this.courseImage,
        this.startingAt,
        this.endingAt,
        this.duration,
        this.isActive,
        this.averageRating});

  RequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseTitle = json['course_title'];
    description = json['description'];
    price = json['price'];
    courseImage = json['course_image'];
    startingAt = json['starting_at'];
    endingAt = json['ending_at'];
    duration = json['duration'];
    isActive = json['is_active'];
    averageRating = json['average_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_title'] = this.courseTitle;
    data['description'] = this.description;
    data['price'] = this.price;
    data['course_image'] = this.courseImage;
    data['starting_at'] = this.startingAt;
    data['ending_at'] = this.endingAt;
    data['duration'] = this.duration;
    data['is_active'] = this.isActive;
    data['average_rating'] = this.averageRating;
    return data;
  }
}