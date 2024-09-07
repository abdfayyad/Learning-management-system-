import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:first/Both/Login/login.dart';
import 'package:first/Both/Signup/bloc/cubit.dart';
import 'package:first/Both/Signup/bloc/status.dart';
import 'package:first/StudentRole/Home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../AdminRole/Home/home_page.dart';
import '../../Const/shared_prefirance.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var formKey = GlobalKey<FormState>();

  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  bool showPass = true;
  String role = 'student';
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInScreenStates>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            SharedPref.saveData(key: 'token', value: state.signINModel.token)
                .then((value) {
              print(SharedPref.getData(key: 'token'));
            });
            SharedPref.saveData(key: 'role', value: state.signINModel.role)
                .then((value) {
              print(SharedPref.getData(key: 'token'));
            });
            if (state.signINModel.role == 'teacher') {
              Flushbar(
                  titleText: Text(
                    "Hello Teacher",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.yellow[600],
                        fontFamily: "ShadowsIntoLightTwo"),
                  ),
                  messageText: Text(
                    "Welcome in our application",
                    style: TextStyle(fontSize: 16.0, color: Colors.green),
                  ),
                  duration: Duration(seconds: 3),
                  margin: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(8))
                  .show(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomePageAdmin()));
            } else if (state.signINModel.role == 'student') {
              Flushbar(
                  titleText: Text(
                    "Hello Student",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.yellow[600],
                        fontFamily: "ShadowsIntoLightTwo"),
                  ),
                  messageText: Text(
                    "Welcome in our application",
                    style: TextStyle(fontSize: 16.0, color: Colors.green),
                  ),
                  duration: Duration(seconds: 3),
                  margin: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(8))
                  .show(context);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageStudent()),
                      (Route<dynamic> route) => false);
            } else {
              Flushbar(
                  titleText: Text(
                    "Welcome in our application",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.yellow[600],
                        fontFamily: "ShadowsIntoLightTwo"),
                  ),
                  messageText: Text(
                    "If you are admin or super admin, you can log in from the web application",
                    style: TextStyle(fontSize: 16.0, color: Colors.green),
                  ),
                  duration: Duration(seconds: 3),
                  margin: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(8))
                  .show(context);
            }
          }
          if (state is SignInErrorState) {
            Flushbar(
                titleText: Text(
                  "Error register",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.deepPurple,
                      fontFamily: "ShadowsIntoLightTwo"),
                ),
                messageText: Text(
                  "this email is taken",
                  style: TextStyle(fontSize: 16.0, color: Colors.deepPurple),
                ),
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red,
                margin: EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(8))
                .show(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('SignUp'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: userFirstNameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter User Name Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'User name',
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                                hintText: 'Enter User Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0)))),


                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Phone Number Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Phone Number',
                                prefixIcon: Icon(
                                  Icons.phone,
                                ),
                                hintText: 'Enter Phone Number',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: emailAddressController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Email Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                                hintText: 'Enter Email Address',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty';
                            }
                            return null;
                          },
                          obscureText: SignInCubit.get(context).isPasswordShow,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  SignInCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                icon: Icon(SignInCubit.get(context).suffix),
                              ),
                              hintText: 'Enter Your Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: passwordConfirmationController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password confirmation must not be empty';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          obscureText: SignInCubit.get(context).isPasswordShow,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  SignInCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                icon: Icon(SignInCubit.get(context).suffix),
                              ),
                              hintText: 'Confirm Your Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: accountNumberController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Account Number Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Account Number',
                                prefixIcon: Icon(
                                  Icons.account_balance,
                                ),
                                hintText: 'Enter Account Number',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0)))),

                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Role:'),
                            Radio<String>(
                              value: 'teacher',
                              groupValue: role,
                              onChanged: (String? value) {
                                setState(() {
                                  role = value!;
                                });
                              },
                            ),
                            Text('Teacher'),
                            Radio<String>(
                              value: 'student',
                              groupValue: role,
                              onChanged: (String? value) {
                                setState(() {
                                  role = value!;
                                });
                              },
                            ),
                            Text('Student'),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        _image == null
                            ? Text('No image selected.')
                            : Image.file(File(_image!.path)),
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: Text('Pick Image'),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              SignInCubit.get(context).userSignUp(
                                  name: userFirstNameController.text,
                                  email: emailAddressController.text,
                                  password: passwordController.text,
                                  passwordConfirmation:
                                  passwordConfirmationController.text,
                                  role: role,
                                  phoneNumber:phoneNumberController.text ,
                                  image: _image,
                                  accountNumber: accountNumberController.text);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                            ),
                            height: 40.0,
                            width: 100.0,
                            child: Center(
                                child: Text('SIGN UP', style: TextStyle())),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account?'),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.blue),
                                  ))
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
