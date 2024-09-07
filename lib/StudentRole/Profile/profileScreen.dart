import 'dart:convert';

import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:first/StudentRole/Home/home_page.dart';
import 'package:first/StudentRole/Profile/bloc/profileServer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first/StudentRole/Profile/bloc/cubit.dart';
import 'package:first/StudentRole/Profile/bloc/status.dart';
import 'package:http/http.dart'as http;
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(ProfileService())..fetchProfile(),
      child: BlocConsumer<ProfileCubit, ProfileStatus>(
        listener: (context, state) {
          if (state is ProfileErrorStatus) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error loading profile")),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoadingStatus) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileSuccessStatus) {
            return _buildProfile(context, state.profileModel);
          } else {
            return Center(child: Text("Unknown state"));
          }
        },
      ),
    );
  }
  Future<void> editProfile(String newName, String newPhone, String newEmail) async {

    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/api/student/profile/edit'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
        },
        body: jsonEncode({'name': newName, 'phone': newPhone, 'email': newEmail}),
      );

      // Print response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {


      } else {
        // Handle different status codes and print error details
        print('Error: ${response.statusCode} - ${response.body}');

      }
    } catch (error) {
      print('Exception caught: $error');

    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {

    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/api/student/profile/change_password'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
        },
        body: jsonEncode({'old_password': oldPassword, 'new_password': newPassword}),
      );
      // Print response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {

      } else {

        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {

    }
  }
  Widget _buildProfile(BuildContext contexts, ProfileModel profile) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage("${profile.image}"),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${profile.name}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Phone: ${profile.phone}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Your email:${profile.email}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Your Balance :${profile.balance}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showEditProfileDialog(contexts);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        _showChangePasswordDialog(contexts);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: Text(
                        'Change Password',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    String? newName;
    String? newPhone;
    String? newEmail;

    showDialog(
      context: context,
      builder: (BuildContext contextx) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'New Name', border: OutlineInputBorder()),
                onChanged: (value) => newName = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'New Phone', border: OutlineInputBorder()),
                onChanged: (value) => newPhone = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'New Email', border: OutlineInputBorder()),
                onChanged: (value) => newEmail = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async{
             await   editProfile("$newName", "$newPhone", "$newEmail");
                // Navigator.of(context).pop();
             Navigator.pushAndRemoveUntil(
               context,
               MaterialPageRoute(builder: (context) => HomePageStudent()),
                   (Route<dynamic> route) => false, // This removes all the previous routes
             );
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    String? oldPassword;
    String? newPassword;

    showDialog(
      context: context,
      builder: (BuildContext contextx) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Old Password', border: OutlineInputBorder()),
                obscureText: true,
                onChanged: (value) => oldPassword = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'New Password', border: OutlineInputBorder()),
                obscureText: true,
                onChanged: (value) => newPassword = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async{
            await  changePassword("$oldPassword", "$newPassword");

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePageStudent()),
                  (Route<dynamic> route) => false, // This removes all the previous routes
            );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
