import 'package:first/StudentRole/Degree/bloc/cubit.dart';
import 'package:first/StudentRole/Degree/bloc/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Degree extends StatelessWidget {
  Degree({super.key});
  DegreeModel? degreeModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DegreeCubit()..getDegreeStudent(),
      child: BlocConsumer<DegreeCubit, DegreeStatus>(
        listener: (context, state) {
          if (state is DegreeSuccess) {
            degreeModel = state.degreeModel;
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: degreeModel != null
                ? GridView.count(
              crossAxisCount: 1,
              children: List.generate(degreeModel!.marks!.length, (index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage("${degreeModel!.marks![index].courseImage}"),
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${degreeModel!.marks![index].courseTitle}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Degree: ${degreeModel!.marks![index].result}',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Date: ${degreeModel!.marks![index].date}',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              }),
            )
                : Center(child: CircularProgressIndicator()), // Show loading indicator while waiting for data
          );
        },
      ),
    );
  }
}
