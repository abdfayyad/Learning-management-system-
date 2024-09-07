

import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:first/StudentRole/Search/bloc/searchCourseModel.dart';
import 'package:first/StudentRole/Search/enroll_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}


Future<SearchCourseModel?> fetchCourses(String query) async {
  final String apiUrl = '$BASE_URL/api/student/courses/search';

  try {
    final response = await http.post(Uri.parse(apiUrl),body:{
      "keyword":query
    },headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return SearchCourseModel.fromJson(jsonResponse);
    } else {
      print('Failed to load courses');
      print(response.body);
      return null;
    }
  } catch (e) {
    print('Error occurred: $e');
    return null;
  }
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  String filter = '';
  SearchCourseModel? searchResult;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onChanged: (value) {
            setState(() {
              filter = value;
            });
            _searchCourses(value);
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                setState(() {
                  filter = '';
                  searchResult = null;
                });
              },
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : searchResult != null && searchResult!.searchCourse != null
          ? ListView.builder(
        itemCount: searchResult!.searchCourse!.length,
        itemBuilder: (BuildContext context, int index) {
          final course = searchResult!.searchCourse![index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EnrollScreen(courseStudent: searchResult!.searchCourse![index],)));
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
                      width: 80,
                      height: 90,
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
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(course.courseTitle ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Teacher: Mohamad", style: TextStyle(fontWeight: FontWeight.w500)),
                            Text("Price: ${course.price ?? ''}"),
                            Text("Start date: ${course.startingAt ?? ''}", style: TextStyle(fontSize: 12)),
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
      )
          : Center(child: Text('No results found')),
    );
  }

  void _searchCourses(String query) async {
    setState(() {
      isLoading = true;
    });

    final result = await fetchCourses(query);

    setState(() {
      isLoading = false;
      searchResult = result;
    });
  }
}

