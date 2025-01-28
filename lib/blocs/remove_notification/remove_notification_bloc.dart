import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:power_washer/blocs/remove_notification/remove_notification_event.dart';
import 'package:power_washer/blocs/remove_notification/remove_notification_state.dart';
import 'package:power_washer/utils/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class RemoveNotificationBloc extends Bloc<RemoveNotificationEvent, RemoveNotificationState> {
  RemoveNotificationBloc() : super(RemoveNotificationInitial()) {
    on<RemoveNotificationButtonPressed>(_onRemoveNotificationButtonPressed);
  }

  void _onRemoveNotificationButtonPressed(RemoveNotificationButtonPressed event, Emitter<RemoveNotificationState> emit) async {
    emit(RemoveNotificationLoading());

    // Initialize preferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(AppString.kPrefUserIdKey);

    try {
      // Prepare request body
      final body = {
        'user_id': userId,
        'notification_id': event.notificationId,
      };

      print('Request body: $body');

      // Send POST request
      final http.Response response = await http.post(
        Uri.parse('${AppString.kBaseUrl}notification/remove'),
        headers: {
          'Authorization': 'Bearer ${preferences.getString(AppString.kPrefToken).toString()}',
        },
        body: body,
      );

      // Parse response
      var _responseData = json.decode(response.body.toString());


      if (_responseData['status'] == AppString.kSuccess) {
        print('Response from service: ${response.body}');
        emit(RemoveNotificationSuccess());
      } else {
        emit(RemoveNotificationFailure(_responseData['message']));
      }
    } catch (error) {
      emit(RemoveNotificationFailure("An error occurred: $error"));
    }
  }
}
