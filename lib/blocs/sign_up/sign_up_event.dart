import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String deviceToken;
  final String deviceType;
  const SignUpButtonPressed({required this.name, required this.phone, required this.email,required this.password,required this.deviceToken, required this.deviceType, });

  @override
  List<Object> get props => [email,password];
}
