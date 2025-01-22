import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// Events
abstract class NotificationEvent {}

class FetchNotification extends NotificationEvent {}


class LoadNotificationPageData extends NotificationEvent {
  /* String? userId;*/

  LoadNotificationPageData(/*this.userId,*/ );

  @override
  List<Object> get props => [/*userId!*/];
}

