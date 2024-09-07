import 'package:first/StudentRole/exams/bloc/cubit.dart';
import 'package:first/StudentRole/exams/bloc/status.dart';
import 'package:first/StudentRole/exams/exam_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Exams extends StatelessWidget {
  const Exams({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ExamsStudentCubit()..fetchExams(),
      child: BlocConsumer<ExamsStudentCubit, ExamsStudentStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ExamsStudentInitial) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ExamsStudentLoaded) {
            return Scaffold(
              body: ListView.builder(
                itemCount: state.examModel.exams?.length,
                itemBuilder: (BuildContext context, int index) {
                  final exam = state.examModel.exams![index];
                  final int id=state.examModel.exams![index].id;
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SolveExamStudent(id:id,),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/ff.jpg"),
                                  fit: BoxFit.fill,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${exam.title}",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Course: ${exam.courseTitle}",
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                    Text("Created at: ${exam.createdAt}"),
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
          } else if (state is ExamsStudentError) {
            return Scaffold(
              body: Center(child: Text(state.message)),
            );
          } else {
            return Scaffold(
              body: Center(child: Text("Unknown state")),
            );
          }
        },
      ),
    );
  }
}
