// abstract class ForgotPasswordEvent {}
//
// class ForgotPasswordSubmitted extends ForgotPasswordEvent {
//   final String email;
//
//   ForgotPasswordSubmitted(this.email);
// }

import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotButtonPressed extends ForgotPasswordEvent {
  final String email;
  const ForgotButtonPressed({required this.email});

  @override
  List<Object> get props => [email];
}
