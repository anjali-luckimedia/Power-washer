// States


import '../../model/notification_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final NotificationModel notificationModel;

  NotificationLoaded(this.notificationModel);
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}