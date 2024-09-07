import 'dart:convert';
import 'dart:io';

import 'package:first/Both/Signup/bloc/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Const/end_point.dart';

class SignInCubit extends Cubit<SignInScreenStates> {
  String? errorState;
  SignInCubit() : super(SignInInitialState());
  static SignInCubit get(context) => BlocProvider.of(context);
  late SignINModel signINModel;

  Future<void> userSignUp({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role,
    required String phoneNumber,
    required String accountNumber,
    XFile? image,
  }) async {
    emit(SignInLoadingState());

    try {
      var uri = Uri.parse('$BASE_URL/api/register'); // Adjust the URL as needed

      var request = http.MultipartRequest('POST', uri);

      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['password_confirmation'] = passwordConfirmation;
      request.fields['role'] = role;
      request.fields['card_number'] = accountNumber ;
      request.fields['phone_number']=phoneNumber;
      if (image != null) {
        var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
        var length = await image.length();
        var multipartFile = http.MultipartFile('image', stream, length, filename: image.name);
        request.files.add(multipartFile);
      }
print(request);
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print(responseData);

        var decodedData = jsonDecode(responseData);
        signINModel = SignINModel.fromJson(decodedData);
        emit(SignInSuccessState(signINModel));
      } else {
        var responseData = await response.stream.bytesToString();
        // print(responseData);
        var decodedData = jsonDecode(responseData);
        var errorMessage = decodedData['message'];
        emit(SignInErrorState());
      }
    } catch (e) {
      emit(SignInErrorState());
    }
  }

  IconData suffix = Icons.visibility;
  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;

    suffix = isPasswordShow ? Icons.visibility : Icons.visibility_off;
    emit(SignInChangePasswordVisibilityState());
  }
}
