import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_string.dart';
import 'logout_event.dart';
import 'logout_state.dart';
import 'package:http/http.dart' as http;

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  void _onLogoutButtonPressed(
      LogoutButtonPressed event, Emitter<LogoutState> emit) async {
    emit(LogoutLoading());
    final preferences = await SharedPreferences.getInstance();
    try {

      print(event.deviceToken);
      print('Bearer ${preferences.getString(AppString.kPrefToken).toString()}');
      final http.Response response = await http.post(
          Uri.parse('${AppString.kBaseUrl}logout'),
          headers: {
            'Authorization': 'Bearer ${preferences.getString(AppString.kPrefToken).toString()}'},
          body: {
            'user_id':preferences.getString(AppString.kPrefUserIdKey).toString(),
            'device_token': event.deviceToken,
          });

      var _responseData = json.decode(response.body.toString());
      print('response from service ${response.body}');

        if (_responseData['status'] == AppString.kSuccess) {
          await preferences.clear();
          preferences.setBool(AppString.kIsLoggedIn, false);
          emit(LogoutSuccess());
        }
        else{
          emit(LogoutFailure(_responseData['message']));
        }

    } catch (error) {
      emit(LogoutFailure("An error occurred ${error}"));
    }
  }
}
