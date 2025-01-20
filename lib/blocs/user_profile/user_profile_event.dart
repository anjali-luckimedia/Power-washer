import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// Events
abstract class UserProfileEvent {}

class FetchUserProfile extends UserProfileEvent {}


class LoadUserProfilePageData extends UserProfileEvent {
  /* String? userId;*/

  LoadUserProfilePageData(/*this.userId,*/ );

  @override
  List<Object> get props => [/*userId!*/];
}

