abstract class ProfileStatus{}
 class ProfileInitializedStatus extends ProfileStatus{}
class ProfileLoadingStatus extends ProfileStatus{}
class ProfileSuccessStatus extends ProfileStatus{
 ProfileModel profileModel;

 ProfileSuccessStatus(this.profileModel);
}
class ProfileErrorStatus extends ProfileStatus{}

class ProfileModel {
 final String ?image;
 final String ?phone;
 final String ?name;
 final String ?email;

 ProfileModel({required this.image, required this.phone, required this.name, required this.email});

 factory ProfileModel.fromJson(Map<String, dynamic> json) {
  return ProfileModel(
   image: json['image'],
   phone: json['phone'],
   name: json['name'],
   email: json['email'],
  );
 }
}
