import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:power_washer/blocs/resend_otp/resend_otp_event.dart';
import 'package:power_washer/blocs/resend_otp/resend_otp_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_string.dart';
import 'package:http/http.dart' as http;

class ResendOtpBloc extends Bloc<ResendOtpEvent, ResendOtpState> {
  ResendOtpBloc() : super(ResendOtpInitial()) {
    on<ResendOtpButtonPressed>(_onResendOtpButtonPressed);
  }

  void _onResendOtpButtonPressed(
      ResendOtpButtonPressed event, Emitter<ResendOtpState> emit) async {
    emit(ResendOtpLoading());
    final preferences = await SharedPreferences.getInstance();
    try {

     // print(event.deviceToken);
      final http.Response response = await http.post(
          Uri.parse('${AppString.kBaseUrl}OTP/resend'),

          body: {
            'user_id':preferences.getString(AppString.kPrefUserIdKey).toString(),
          });

      var _responseData = json.decode(response.body.toString());
      print('response from service ${response.body}');

        if (_responseData['status'] == AppString.kSuccess) {
          await preferences.clear();
          preferences.setBool(AppString.kIsLoggedIn, false);
          emit(ResendOtpSuccess());
        }
        else{
          emit(ResendOtpFailure(_responseData['message']));
        }

    } catch (error) {
      emit(ResendOtpFailure("An error occurred ${error}"));
    }
  }
}
