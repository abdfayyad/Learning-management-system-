import 'package:first/StudentRole/Courses/bloc/cubit.dart';
import 'package:first/StudentRole/Courses/bloc/status.dart';
import 'package:first/StudentRole/Courses/details_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesScreen extends StatelessWidget {
  CoursesScreen({super.key});
  CourseModelStudent? courseModelStudent;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CoursesStudentCubit()..getCoursesStudent(),
      child: BlocConsumer<CoursesStudentCubit, CoursesStudentStatus>(
        listener: (context, state) {
          if (state is CoursesSuccess) {
            courseModelStudent = state.courseModelStudent;
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: courseModelStudent != null && courseModelStudent!.myCourses != null
                ? ListView.builder(
              itemCount: courseModelStudent!.myCourses!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsCourseStudent(
                          courseStudent: courseModelStudent!.myCourses![index],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 2, left: 8.0, right: 8.0, bottom: 2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 90,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("${courseModelStudent!.myCourses![index].courseImage}"),
                                fit: BoxFit.fill,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "course: ${courseModelStudent!.myCourses![index].title}",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Teacher : ${courseModelStudent!.myCourses![index].title}",
                                    style: TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Text("price: ${courseModelStudent!.myCourses![index].price}\$"),
                                  Text(
                                    "date enrolled : ${courseModelStudent!.myCourses![index].startingAt}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
                : Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
