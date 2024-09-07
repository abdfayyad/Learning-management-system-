
import 'package:first/AdminRole/Home/bloc/status.dart';
import 'package:first/AdminRole/Lessons/lessons.dart';
import 'package:first/AdminRole/Profile/profileScreen.dart';
import 'package:first/AdminRole/Student/student.dart';
import 'package:first/AdminRole/exams/Exams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Courses/courses.dart';

class HomePageCubit extends Cubit<HomePageStatus>{
HomePageCubit():super(InitializedHomePageStatus());
static HomePageCubit get(context)=>BlocProvider.of(context);
int currentIndex = 2;

List<Widget> screen = [
  CoursesScreen(),
  ProfileScreen(),
  LessonsTeacher(),
  Exams(),
  Students(),

];

void changeIndex(int index) {

  currentIndex = index;

  emit(HomeChangeBottomNavBarState());
}
}