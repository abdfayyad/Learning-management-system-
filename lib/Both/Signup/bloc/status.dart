abstract class SignInScreenStates{}

class SignInInitialState extends SignInScreenStates{}
class SignInLoadingState extends SignInScreenStates{}
class SignInSuccessState extends SignInScreenStates
{
SignINModel signINModel;

SignInSuccessState(this.signINModel);
}
class SignInErrorState extends SignInScreenStates{

}
class SignInChangePasswordVisibilityState extends SignInScreenStates{}


class SignINModel {
  String? token;
  String? role;

  SignINModel({this.token, this.role});

  SignINModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['role'] = this.role;
    return data;
  }
}