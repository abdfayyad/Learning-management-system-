import 'package:first/AdminRole/Courses/bloc/status.dart';
import 'package:first/AdminRole/Lessons/add_lesson.dart';
import 'package:first/AdminRole/exams/addExam.dart';
import 'package:flutter/material.dart';

class DetailsCourseTeacher extends StatelessWidget {
  const DetailsCourseTeacher({Key? key, required this.courseTeacher});
final CourseTeacher courseTeacher;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details',style:TextStyle(color: Colors.white) ,),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddExamScreen(id :courseTeacher.id)));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage('${courseTeacher.courseImage}'), // Replace this with your image path
            ),
            SizedBox(height: 20),
            Text(
              'Title ${courseTeacher.courseTitle}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Price\$${courseTeacher.price}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Description: ${courseTeacher.description}',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Start Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('${courseTeacher.startingAt}'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'End Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('${courseTeacher.endingAt}'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddLesson(courseTeacher.id)));

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text('Add Lesson',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Course'),
          content: Text('Are you sure you want to delete this course?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Dismiss the dialog and return false
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Dismiss the dialog and return true
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    ).then((confirmed) {
      if (confirmed != null && confirmed) {
        // If confirmed is true, proceed with deletion
        // Add your delete logic here
      }
    });
  }
}
