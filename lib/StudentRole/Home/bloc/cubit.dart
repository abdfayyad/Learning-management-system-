

import 'package:first/StudentRole/Courses/courses.dart';
import 'package:first/StudentRole/Degree/degree_screen.dart';
import 'package:first/StudentRole/Home/bloc/status.dart';
import 'package:first/StudentRole/Lessons/lessons.dart';
import 'package:first/StudentRole/Profile/profileScreen.dart';
import 'package:first/StudentRole/exams/Exams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageStudentCubit extends Cubit<HomePageStudentStatus>{
HomePageStudentCubit():super(InitializedHomePageStatus());
static HomePageStudentCubit get(context)=>BlocProvider.of(context);
int currentIndex = 2;

List<Widget> screen = [
  ProfileScreen(),
  CoursesScreen(),
  LessonsStudent(),
  Exams(),
  Degree(),

];

void changeIndex(int index) {

  currentIndex = index;

  emit(HomeChangeBottomNavBarState());
}
}