
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:power_washer/blocs/sign_up/sign_up_event.dart';
import 'package:power_washer/blocs/sign_up/sign_up_state.dart';
import 'package:power_washer/utils/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpButtonPressed>(_onSignUpButtonPressed);
  }

  void _onSignUpButtonPressed(SignUpButtonPressed event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    final preferences = await SharedPreferences.getInstance();

    try {
      // Print the body before sending the request
      final body = {
        'name' : event.name,
        'email': event.email,
        'password': event.password,
        'phone':event.phone,
        'device_token': event.deviceToken,
        'device_type': event.deviceType,
        'language': 'en',
      };


      print('Request body: $body');

      final http.Response response = await http.post(
        Uri.parse('${AppString.kBaseUrl}register'),
        body: body,
      );

      var _responseData = json.decode(response.body.toString());
      print('response from service ${response.body}');

      if (_responseData['status'] == AppString.kSuccess) {
       // final data = _responseData["data"][0];
        final data = _responseData["data"];
        preferences.setString(AppString.kPrefOtpKey, data['otp'].toString());
        preferences.setString(AppString.kPrefUserIdKey, data['user_id'].toString());
        print(_responseData['message']);
        print(data['otp']);
        print(data['user_id']);
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure(_responseData['message']));
        print(_responseData['message']);
      }
    } catch (error) {
      emit(SignUpFailure("An error occurred ${error}"));
      print("An error occurred ${error}");
    }
  }

}
