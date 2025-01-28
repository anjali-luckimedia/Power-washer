import 'package:equatable/equatable.dart';

abstract class RemoveNotificationState extends Equatable {
  const RemoveNotificationState();

  @override
  List<Object> get props => [];
}

class RemoveNotificationInitial extends RemoveNotificationState {}

class RemoveNotificationLoading extends RemoveNotificationState {}

class RemoveNotificationSuccess extends RemoveNotificationState {}

class RemoveNotificationFailure extends RemoveNotificationState {
  final String error;

  const RemoveNotificationFailure(this.error);

  @override
  List<Object> get props => [error];
}
