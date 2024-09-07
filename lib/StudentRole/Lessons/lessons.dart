import 'package:first/StudentRole/Lessons/bloc/cubit.dart';
import 'package:first/StudentRole/Lessons/bloc/status.dart';
import 'package:first/StudentRole/Lessons/details_lesson.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonsStudent extends StatelessWidget {
  LessonsStudent({super.key});
  LessonModelStudent? lessonModelStudent;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LessonsStudentCubit()..getLessonsStudent(),
      child: BlocConsumer<LessonsStudentCubit, LessonsStudentStatus>(
        listener: (context, state) {
          if (state is LessonsSuccess) {
            lessonModelStudent = state.lessonModelStudent;
          }
        },
        builder: (context, state) {
          if (state is LessonsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (lessonModelStudent == null || lessonModelStudent!.lessons == null) {
            return Center(child: Text('No lessons available.'));
          } else {
            return Scaffold(
              body: ListView.builder(
                itemCount: lessonModelStudent!.lessons!.length,
                itemBuilder: (BuildContext context, int index) {
                  final lesson = lessonModelStudent!.lessons![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsLessonStudent(lesson),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/ff.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${lesson.title}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        Text(
                                          "${lesson.title}", // This should probably be something else
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${lesson.startDate}",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
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
              ),
            );
          }
        },
      ),
    );
  }
}

