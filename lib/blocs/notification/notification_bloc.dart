// BLoC


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/notification/notification_event.dart';
import 'package:power_washer/blocs/notification/notification_state.dart';
import 'package:power_washer/repositary/api_repositary.dart';

class NotificationBLoc extends Bloc<NotificationEvent, NotificationState> {
  final ApiService _apiService; // Inject the ApiService dependency
  NotificationBLoc(this._apiService) : super(NotificationLoading()) {
    on<LoadNotificationPageData>((event, emit) async {
      emit(NotificationLoading());
      try {
        final notificationDataModel = await _apiService.fetchNotification(/*userId: '1'*/);
        emit(NotificationLoaded(notificationDataModel));
      } catch (error) {
        emit(NotificationError(error.toString()));
      }
    });

  }

}







