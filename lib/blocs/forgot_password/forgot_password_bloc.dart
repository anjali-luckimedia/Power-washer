import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_string.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotButtonPressed>(_onForgotButtonPressed);
  }

  void _onForgotButtonPressed(ForgotButtonPressed event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    final preferences = await SharedPreferences.getInstance();
    try {
      // Print the body before sending the request
      final body = {
        'email': event.email,
      };

      print('Request body: $body');

      final http.Response response = await http.post(
        Uri.parse('${AppString.kBaseUrl}password/forget'),
        body: body,
      );

      var _responseData = json.decode(response.body.toString());
      print('response from service ${response.body}');

      if (_responseData['status'] == AppString.kSuccess) {
        final data = _responseData["data"][0];

        emit(ForgotPasswordSuccess());
      } else {
        emit(ForgotPasswordFailure(_responseData['message']));
      }
    } catch (error) {
      emit(ForgotPasswordFailure("An error occurred ${error}"));
    }
  }

}
