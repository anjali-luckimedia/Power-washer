
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:power_washer/blocs/verify_otp/verify_otp_event.dart';
import 'package:power_washer/blocs/verify_otp/verify_otp_state.dart';
import 'package:power_washer/utils/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(VerifyOtpInitial()) {
    on<VerifyOtpButtonPressed>(_onVerifyOtpButtonPressed);
  }

  void _onVerifyOtpButtonPressed(VerifyOtpButtonPressed event, Emitter<VerifyOtpState> emit) async {
    emit(VerifyOtpLoading());
    final preferences = await SharedPreferences.getInstance();
    try {
      // Print the body before sending the request
      final body = {

        'user_id': event.userId,
        'otp': event.otp,
        'device_token': event.deviceToken,
        'device_type': event.deviceType,
        'language': 'en',
      };

      print('Request body: $body');

      final http.Response response = await http.post(
        Uri.parse('${AppString.kBaseUrl}OTP/verify'),
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
        emit(VerifyOtpSuccess());
      } else {


        emit(VerifyOtpFailure(_responseData['message']));
      }
    } catch (error) {
      emit(VerifyOtpFailure("An error occurred ${error}"));
    }
  }

}
