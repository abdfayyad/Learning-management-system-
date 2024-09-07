import 'package:first/AdminRole/Home/home_page.dart';
import 'package:first/AdminRole/Profile/bloc/cubit.dart';
import 'package:first/AdminRole/Profile/bloc/profileServer.dart';
import 'package:first/AdminRole/Profile/bloc/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first/AdminRole/Profile/bloc/cubit.dart';
import 'package:first/AdminRole/Profile/bloc/profileServer.dart';
import 'package:first/AdminRole/Profile/bloc/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                        "${profile.phone}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${profile.email}",
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
              onPressed: () {
                final cubit = context.read<ProfileCubit>();
                cubit.updateProfile(newName!, newPhone!, newEmail!);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageAdmin()),
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
              onPressed: () {
                final cubit = context.read<ProfileCubit>();
                cubit.changePassword(oldPassword!, newPassword!);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageAdmin()),
                      (Route<dynamic> route) => false, // This removes all the previous routes
                );
                // Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
