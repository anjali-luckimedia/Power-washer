// BLoC


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/user_profile/user_profile_state.dart';

import '../../repositary/api_repositary.dart';
import 'user_profile_event.dart';

class UserProfileBLoc extends Bloc<UserProfileEvent, UserProfileState> {
  final ApiService _apiService; // Inject the ApiService dependency
  UserProfileBLoc(this._apiService) : super(UserProfileLoading()) {
    on<LoadUserProfilePageData>((event, emit) async {
      emit(UserProfileLoading());
      try {
        final userDataModel = await _apiService.fetchUserData(/*userId: event.userId!*/);
        emit(UserProfileLoaded(userDataModel));
      } catch (error) {
        emit(UserProfileError(error.toString()));
      }
    });

  }

}







