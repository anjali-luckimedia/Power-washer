// States
import 'package:power_washer/model/user_profile_model.dart';
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserProfileModel userProfileModel;

  UserProfileLoaded(this.userProfileModel);
}

class UserProfileError extends UserProfileState {
  final String message;

  UserProfileError(this.message);
}