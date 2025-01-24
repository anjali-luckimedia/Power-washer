import 'package:equatable/equatable.dart';

abstract class ResendOtpState extends Equatable {
  const ResendOtpState();

  @override
  List<Object> get props => [];
}

class ResendOtpInitial extends ResendOtpState {}

class ResendOtpLoading extends ResendOtpState {}

class ResendOtpSuccess extends ResendOtpState {}

class ResendOtpFailure extends ResendOtpState {
  final String error;

  const ResendOtpFailure(this.error);

  @override
  List<Object> get props => [error];
}
