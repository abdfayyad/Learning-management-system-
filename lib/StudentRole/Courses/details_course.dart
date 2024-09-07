import 'package:first/StudentRole/Courses/bloc/status.dart';
import 'package:flutter/material.dart';

class DetailsCourseStudent extends StatelessWidget {
   DetailsCourseStudent({super.key, required this.courseStudent});
final MyCourses courseStudent;
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
              'Title : ${courseStudent.title}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${courseStudent.price}',
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

          ],
        ),
      ),
    );
  }
}
