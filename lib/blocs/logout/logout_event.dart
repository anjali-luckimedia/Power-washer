import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

class LogoutButtonPressed extends LogoutEvent {
  final String deviceToken;
  const LogoutButtonPressed({required this.deviceToken,});

  @override
  List<Object> get props => [deviceToken,];
}
