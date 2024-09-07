import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first/AdminRole/Lessons/bloc/cubit.dart';
import 'package:first/AdminRole/Lessons/bloc/status.dart';
import 'package:first/AdminRole/Lessons/details_lesson.dart';
import 'package:first/AdminRole/Lessons/add_lesson.dart';

class LessonsTeacher extends StatelessWidget {
   LessonsTeacher({Key? key}) : super(key: key);
LessonModelTeacher? lessonModelTeacher;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LessonsCubit()..getLessonsTeacher(),
      child: BlocConsumer<LessonsCubit, LessonsStatus>(
        listener: (context, state) {
          if(state is LessonsSuccess)
            lessonModelTeacher=state.lessonModelTeacher;
          print(lessonModelTeacher!.lessons!.length);
        },
        builder: (context, state) {
          return Scaffold(


            body: state is LessonsLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: lessonModelTeacher?.lessons?.length ,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsLessonTeacher(lessonModelTeacher!.lessons![index])));
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
                                        " ${lessonModelTeacher!.lessons![index].lessonTitle}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                      Text(
                                        "${lessonModelTeacher!.lessons![index].courseTitle}",
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
                                        "${lessonModelTeacher!.lessons![index].startDate}",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _showDeleteConfirmationDialog(context);
                                        },
                                        icon: Icon(Icons.delete, color: Colors.red),
                                      )
                                    ],
                                  )
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
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this lesson?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Perform delete operation here
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
