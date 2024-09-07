
import 'package:first/AdminRole/Courses/addCourse.dart';
import 'package:first/AdminRole/Courses/bloc/cubit.dart';
import 'package:first/AdminRole/Courses/bloc/status.dart';
import 'package:first/AdminRole/Courses/details_course.dart';
import 'package:first/AdminRole/Home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesScreen extends StatelessWidget {
  CoursesScreen({Key? key});

  CourseModelTeacher? courseModelTeacher;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      CoursesCubit()
        ..getCoursesTeacher(),
      child: BlocConsumer<CoursesCubit, CoursesStatus>(
        listener: (context, state) {
          if (state is CoursesSuccess) {
            courseModelTeacher = state.courseModelTeacher;
          }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddCourse()));
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.deepPurple,
            ),
            body: state is CoursesLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : courseModelTeacher != null &&
                courseModelTeacher!.courseTeacher != null &&
                courseModelTeacher!.courseTeacher!.isNotEmpty
                ? ListView.builder(
              itemCount: courseModelTeacher!.courseTeacher!.length,
              itemBuilder: (BuildContext context, int index) {
                final courseTeacher = courseModelTeacher!.courseTeacher![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsCourseTeacher(courseTeacher: courseTeacher),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      leading: Container(
                        width: 80,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("${courseTeacher.courseImage}"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      title: Text(
                        "Title ${courseTeacher.courseTitle}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Price: ${courseTeacher.price}"),
                          Text("Date Started: ${courseTeacher.startingAt}"),
                          Text("Date Finished: ${courseTeacher.endingAt}"),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteDialog(context, courseTeacher.id);
                        },
                      ),
                    ),
                  ),
                );
              },
            )
                : Center(
              child: Text('Failed to load courses.'),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext contextx, int? courseId) {
    if (courseId == null) {
      return;
    }
    showDialog(
      context: contextx,
      builder: (BuildContext context) {
        // Use BlocProvider.value to provide the existing CoursesCubit to the dialog
        return BlocProvider.value(
          value: BlocProvider.of<CoursesCubit>(contextx),
          child: AlertDialog(
            title: Text("Delete Course"),
            content: Text("Are you sure you want to delete this course?"),
            actions: <Widget>[
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text("Delete"),
                onPressed: () {
                  BlocProvider.of<CoursesCubit>(contextx).deleteCourse(courseId);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePageAdmin()),
                        (Route<dynamic> route) => false, // This removes all the previous routes
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}