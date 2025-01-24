

import 'package:equatable/equatable.dart';

abstract class UserEditProfileState extends Equatable {
  const UserEditProfileState();

  @override
  List<Object> get props => [];
}

class UserEditProfileInitial extends UserEditProfileState {}

class UserEditProfileLoading extends UserEditProfileState {}

class UserEditProfileSuccess extends UserEditProfileState {}

class UserEditProfileFailure extends UserEditProfileState {
  final String error;

  const UserEditProfileFailure(this.error);

  @override
  List<Object> get props => [error];
}



