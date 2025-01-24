import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_string.dart';
import 'package:http/http.dart' as http;

import 'delete_account_event.dart';
import 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  DeleteAccountBloc() : super(DeleteAccountInitial()) {
    on<DeleteAccountButtonPressed>(_onDeleteAccountButtonPressed);
  }

  void _onDeleteAccountButtonPressed(
      DeleteAccountButtonPressed event, Emitter<DeleteAccountState> emit) async {
    emit(DeleteAccountLoading());
    final preferences = await SharedPreferences.getInstance();
    try {

      //print(event.deviceToken);
      final http.Response response = await http.post(
          Uri.parse('${AppString.kBaseUrl}account/delete'),
          headers: {
            'Authorization': 'Bearer ${preferences.getString(AppString.kPrefToken).toString()}'},
          body: {
            'user_id':preferences.getString(AppString.kPrefUserIdKey).toString(),
          });

      print('${preferences.getString(AppString.kPrefToken).toString()}');
      print('${preferences.getString(AppString.kPrefUserIdKey).toString()}');
      var _responseData = json.decode(response.body.toString());
      print('response from service ${response.body}');

        if (_responseData['status'] == AppString.kSuccess) {
          await preferences.clear();
          preferences.setBool(AppString.kIsLoggedIn, false);
          emit(DeleteAccountSuccess());
        }
        else{
          emit(DeleteAccountFailure(_responseData['message']));
        }

    } catch (error) {
      emit(DeleteAccountFailure("An error occurred ${error}"));
    }
  }
}
