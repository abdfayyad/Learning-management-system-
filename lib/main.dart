import 'package:first/AdminRole/Home/home_page.dart';
import 'package:first/Both/Login/login.dart';
import 'package:first/Both/Signup/siginup.dart';
import 'package:first/Both/splash_screen.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:first/Const/test.dart';
import 'package:first/StudentRole/Home/home_page.dart';
import 'package:first/adminPlatForm/adminPlatform.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: SplashScreen(),
    );
  }
}

