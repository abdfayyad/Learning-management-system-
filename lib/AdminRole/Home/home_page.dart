import 'package:first/AdminRole/CourseRequests/CourseRequest.dart';
import 'package:first/AdminRole/Home/bloc/cubit.dart';
import 'package:first/AdminRole/Home/bloc/status.dart';
import 'package:first/AdminRole/requestsAddCorse/requestsAddCourrs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageAdmin extends StatelessWidget {
  const HomePageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => HomePageCubit(),
        child: BlocConsumer<HomePageCubit, HomePageStatus>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 2,
                title: Text("Learn Me",style: TextStyle(color: Colors.deepPurple),),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RequestAddCourse()));
                    },
                    icon: Icon(
                      Icons.open_in_browser_outlined,
                      color: Colors.deepPurple,

                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>CourseRequest()));
                  //   },
                  //   icon: Icon(
                  //     Icons.move_to_inbox_rounded,
                  //     color: Colors.deepPurple,
                  //   ),
                  // )
                ],
              ),
              body: HomePageCubit.get(context)
                  .screen[HomePageCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: HomePageCubit.get(context).currentIndex,
                onTap: (index) {
                  HomePageCubit.get(context).changeIndex(index);
                },
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.deepPurple,
                unselectedFontSize: 14,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business_sharp, size: 30),
                    label: 'My courses',
                    //backgroundColor: Colors.red
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle, size: 30),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu_book_outlined,
                      size: 30,
                    ),
                    label: 'My lessons',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.library_books_outlined, size: 30),
                    label: 'My exams',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people, size: 30),
                    label: 'Student',
                  ),
                ],
              ),
            );
          },
        ));
  }
}
