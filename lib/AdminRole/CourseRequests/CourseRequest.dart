import 'package:first/AdminRole/CourseRequests/bloc/cubit.dart';
import 'package:first/AdminRole/CourseRequests/bloc/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseRequest extends StatelessWidget {
  const CourseRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CourseRequestCubit(),
      child: BlocConsumer<CourseRequestCubit, CourseRequestStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Student Request",style: TextStyle(color: Colors.white),),
              backgroundColor: Colors.deepPurple, // Change app bar background color
              elevation: 0, // Remove app bar shadow
            ),
            body: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(4), // Add margin to the container
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Rounded corners for the container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.1,
                        blurRadius: 10,
                        offset: Offset(0, 0.1),
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                      ),
                      title: Text(
                        "mohamed",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.deepPurple), // Increase font size and make bold
                      ),
                      subtitle: Text(
                        "course name: c++",
                        style: TextStyle(color: Colors.grey), // Change subtitle text color
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
                                  Text(
                                    'Course Name: C++',
                                    style: TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  Text('Name: mohamed'),
                                  Text('Email: mohamed@gmail.com'),
                                  Text('Phone: 0936741825'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'reject',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('accepted'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'accept',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
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
}
