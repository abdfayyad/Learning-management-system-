import 'package:another_flushbar/flushbar.dart';
import 'package:first/AdminRole/Home/home_page.dart';
import 'package:first/Both/Login/bloc/cubit.dart';
import 'package:first/Both/Login/bloc/status.dart';
import 'package:first/Both/Signup/siginup.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:first/StudentRole/Home/home_page.dart';
import 'package:first/adminPlatForm/adminPlatform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: BlocConsumer<LoginCubit, LoginScreenStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              SharedPref.saveData(key: 'token', value: state.loginModel.token)
                  .then((value) {
                print(SharedPref.getData(key: 'token'));
              });
              SharedPref.saveData(key: 'role', value: state.loginModel.role)
                  .then((value) {
                print(SharedPref.getData(key: 'token'));
              });
              if (state.loginModel.role == 'teacher') {
                Flushbar(
                    titleText: Text("hello Teacher", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow[600], fontFamily:"ShadowsIntoLightTwo"),),
                    messageText: Text("welcome in our application", style: TextStyle(fontSize: 16.0, color: Colors.green),),
                    duration:  Duration(seconds: 3),
                    margin: EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(8)
                ).show(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePageAdmin()));
              } else if (state.loginModel.role == 'student') {
                Flushbar(
                    titleText: Text("Hello Student", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow[600], fontFamily:"ShadowsIntoLightTwo"),),
                    messageText: Text("welcome in our application", style: TextStyle(fontSize: 16.0, color: Colors.green),),
                    duration:  Duration(seconds: 3),
                    margin: EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(8)
                ).show(context);
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => HomeStudent()));
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePageStudent()), (Route<dynamic> route) => false);
              }else if(state.loginModel.role == 'admin'){
                Flushbar(
                    titleText: Text("welcome in our application", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow[600], fontFamily:"ShadowsIntoLightTwo"),),
                    messageText: Text("if you admin or super admin you can login from web application", style: TextStyle(fontSize: 16.0, color: Colors.green),),
                    duration:  Duration(seconds: 3),
                    margin: EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(8)

                ).show(context);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>CourseAdmin()), (Route<dynamic> route) => false);

              }
            }
            if(state is LoginErrorState){
              Flushbar(
                  titleText: Text("error login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.deepPurple, fontFamily:"ShadowsIntoLightTwo"),),
                  messageText: Text("error in your email or password", style: TextStyle(fontSize: 16.0, color: Colors.deepPurple),),
                  duration:  Duration(seconds: 3),
                  backgroundColor: Colors.red,
                  margin: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(8)

              ).show(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [


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
                                      borderRadius:
                                      BorderRadius.circular(30.0)))),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'password must not be empty';
                              }
                              return null;
                            },

                            obscureText: LoginCubit.get(context)
                                .isPasswordShow, //isPasswordShow,
                            decoration: InputDecoration(
                                labelText: 'password',
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    LoginCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  icon: Icon(LoginCubit.get(context).suffix),
                                ),
                                hintText: 'Enter Your Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),

                          MaterialButton(
                            onPressed: () {
                              LoginCubit.get(context).loginUser(
                                  emailAddressController.text, passwordController.text);
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
                                  child: Text('Login', style: TextStyle())),
                            ),


                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Alreadyhaveanaccount'),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUp(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'sign up',
                                      style: TextStyle(color: Colors.blue),
                                    ))
                              ]),
                          const SizedBox(
                            height: 30,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     IconButton(
                          //         icon: const Icon(
                          //           Icons.facebook,
                          //           color: Colors.red,
                          //         ),
                          //         onPressed: () {}),
                          //     const SizedBox(
                          //       width: 30.0,
                          //     ),
                          //     IconButton(
                          //       // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          //         icon: const Icon(
                          //           Icons.facebook,
                          //           color: Colors.blueAccent,
                          //         ),
                          //         onPressed: () {}),
                          //     const SizedBox(
                          //       width: 30.0,
                          //     ),
                          //     IconButton(
                          //       // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          //         icon: const Icon(
                          //           Icons.facebook,
                          //           color: Colors.blue,
                          //         ),
                          //         onPressed: () {}),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
