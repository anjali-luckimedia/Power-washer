
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:power_washer/utils/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:http/http.dart' as http;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final preferences = await SharedPreferences.getInstance();
    try {
      // Print the body before sending the request
      final body = {

        'email': event.email,
        'password': event.password,
        'device_token': event.deviceToken,
        'device_type': event.deviceType,
        'language': 'en',
      };

      print('Request body: $body');

      final http.Response response = await http.post(
        Uri.parse('${AppString.kBaseUrl}login'),
        body: body,
      );

      var _responseData = json.decode(response.body.toString());
      print('response from service ${response.body}');

      if (_responseData['status'] == AppString.kSuccess) {
        final data = _responseData["data"];
        preferences.setString(AppString.kPrefUserIdKey, data['user_id'].toString());
        preferences.setString(AppString.kName, data['name']);
        preferences.setString(AppString.kPEmail, data['email']);
        preferences.setString(AppString.kPPhoneNo, data['phone']);
        preferences.setString(AppString.kPrefDeviceType, data['device_type']);
        preferences.setString(AppString.kPrefDeviceToken, data['device_token']);
        preferences.setString(AppString.kPrefToken, data['token']);
        preferences.setBool(AppString.kIsLoggedIn, true);
        emit(LoginSuccess());
      } else {


        emit(LoginFailure(_responseData['message']));
      }
    } catch (error) {
      emit(LoginFailure("An error occurred ${error}"));
    }
  }

}
