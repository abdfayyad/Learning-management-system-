
import 'package:first/StudentRole/Profile/bloc/profileServer.dart';
import 'package:first/StudentRole/Profile/bloc/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfileCubit extends Cubit<ProfileStatus> {
  final ProfileService profileService;

  ProfileCubit(this.profileService) : super(ProfileInitializedStatus());
  late ProfileModel profile;

  Future<void> fetchProfile() async {
    try {
      emit(ProfileLoadingStatus());
      profile = await profileService.getProfile();
      emit(ProfileSuccessStatus(profile));
    } catch (e) {
      emit(ProfileErrorStatus());
    }
  }

  Future<void> updateProfile(String newName, String newPhone, String newEmail) async {
    try {
      emit(ProfileLoadingStatus());
      await profileService.updateProfile(newName, newPhone, newEmail);
      await fetchProfile();
    } catch (e) {
      emit(ProfileErrorStatus());
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      emit(ProfileLoadingStatus());
      await profileService.changePassword(oldPassword, newPassword);
      emit(ProfileInitializedStatus());
    } catch (e) {
      emit(ProfileErrorStatus());
    }
  }
}
