import 'package:first/AdminRole/Student/bloc/cubit.dart';
import 'package:first/AdminRole/Student/bloc/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'student.dart';

class Students extends StatelessWidget {
  Students({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StudentCubit()..loadStudents(),
      child: Scaffold(
        body: BlocBuilder<StudentCubit, StudentStatus>(
          builder: (context, state) {
            if (state is StudentLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is StudentLoaded) {
              return ListView.builder(
                itemCount: state.students.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(3),
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(state.students[index].photoUrl),
                      ),
                      title: Text(
                        state.students[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        state.students[index].email,
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Student Details'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Name: ${state.students[index].name}'),
                                  Text('Email: ${state.students[index].email}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is StudentError) {
              return Center(child: Text('Failed to load students: ${state.message}'));
            } else {
              return Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
