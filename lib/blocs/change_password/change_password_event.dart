import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangePasswordSubmitted extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordSubmitted({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [oldPassword, newPassword, confirmPassword];
}
