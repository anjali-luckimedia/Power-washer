import 'package:equatable/equatable.dart';

abstract class VerifyOtpEvent extends Equatable {
  const VerifyOtpEvent();

  @override
  List<Object> get props => [];
}

class VerifyOtpButtonPressed extends VerifyOtpEvent {
  final String userId;
  final String otp;
  final String deviceToken;
  final String deviceType;
  const VerifyOtpButtonPressed({required this.userId,required this.otp,required this.deviceToken, required this.deviceType, });

  @override
  List<Object> get props => [userId,otp];
}
