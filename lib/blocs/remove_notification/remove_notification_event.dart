import 'package:equatable/equatable.dart';

abstract class RemoveNotificationEvent extends Equatable {
  const RemoveNotificationEvent();

  @override
  List<Object> get props => [];
}

class RemoveNotificationButtonPressed extends RemoveNotificationEvent {

  final String notificationId;
  const RemoveNotificationButtonPressed({required this.notificationId, });

  @override
  List<Object> get props => [notificationId];
}
