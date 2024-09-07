import 'package:first/AdminRole/exams/addExam.dart';
import 'package:first/AdminRole/exams/bloc/cubit.dart';
import 'package:first/AdminRole/exams/bloc/status.dart';
import 'package:first/AdminRole/exams/exam_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Exams extends StatelessWidget {
  Exams({super.key});
  ExamModel ?examModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ExamsCubit()..getExams(),
      child: BlocConsumer<ExamsCubit, ExamsStatus>(
        listener: (context, state) {
          if (state is ExamsSuccess)
            examModel = state.examModel;
        },
        builder: (context, state) {
          if (examModel == null) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              body: ListView.builder(
                itemCount: examModel!.exams?.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SolveExamTeacher(id: examModel!.exams![index].id,)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
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
                                      "${examModel!.exams![index].courseTitle}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "${examModel!.exams![index].title}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "${examModel!.exams![index].createdAt}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
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
