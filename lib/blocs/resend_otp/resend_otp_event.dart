import 'package:equatable/equatable.dart';

abstract class ResendOtpEvent extends Equatable {
  const ResendOtpEvent();

  @override
  List<Object> get props => [];
}

class ResendOtpButtonPressed extends ResendOtpEvent {
  const ResendOtpButtonPressed();

  @override
  List<Object> get props => [];
}
