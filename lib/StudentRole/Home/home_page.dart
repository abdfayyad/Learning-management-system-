import 'package:first/StudentRole/Home/bloc/cubit.dart';
import 'package:first/StudentRole/Home/bloc/status.dart';
import 'package:first/StudentRole/Search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageStudent extends StatelessWidget {
  const HomePageStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => HomePageStudentCubit(),
        child: BlocConsumer<HomePageStudentCubit, HomePageStudentStatus>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Learn Me"),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchScreen()));
                    },
                    icon: Icon(
                      Icons.search,
                    ),
                  ),
                ],
              ),
              body: HomePageStudentCubit.get(context)
                  .screen[HomePageStudentCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: HomePageStudentCubit.get(context).currentIndex,
                onTap: (index) {
                  HomePageStudentCubit.get(context).changeIndex(index);
                },
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.blue,
                unselectedFontSize: 14,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle, size: 30),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business_sharp, size: 30),
                    label: 'Courses',
                    //backgroundColor: Colors.red
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu_book_outlined,
                      size: 30,
                    ),
                    label: 'Lessons',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.library_books_outlined, size: 30),
                    label: 'Exams',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school_sharp, size: 30),
                    label: 'Degree',
                  ),
                ],
              ),
            );
          },
        ));
  }
}
