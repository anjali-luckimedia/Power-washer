import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_string.dart';
import 'user_edit_profile_event.dart';
import 'user_edit_profile_state.dart';
import 'package:http/http.dart' as http;


import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
class UserEditProfileBloc extends Bloc<UserEditProfileEvent, UserEditProfileState> {
  UserEditProfileBloc() : super(UserEditProfileInitial()) {
    on<EditProfileButtonPressed>(_onProfileButtonPressed);
  }

  void _onProfileButtonPressed(EditProfileButtonPressed event, Emitter<UserEditProfileState> emit) async {
    emit(UserEditProfileLoading());

    final preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(AppString.kPrefUserIdKey);
    String? token = preferences.getString(AppString.kPrefToken);

    print('userId:$userId');
    print('Bearer:$token');

    try {
      final Uri uri = Uri.parse('${AppString.kBaseUrl}profile/set');
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['user_id'] = userId ?? ''
        ..fields['name'] = event.name
        ..fields['email'] = event.email
        ..fields['phone'] = event.phone;
      if (event.image != null && event.image!.path.isNotEmpty) {
        final mimeTypeData = lookupMimeType(event.image!.path)!.split('/');
        request.files.add(await http.MultipartFile.fromPath(
          'profile_image', event.image!.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ));
      }



      // Print request data for debugging
      print('Request URL: $uri');
      print('Request Headers: ${request.headers}');
      print('Request Fields: ${request.fields}');
      if (request.files.isNotEmpty) {
        for (var file in request.files) {
          print('File Field: ${file.field}');
          print('File Name: ${file.filename}');
        }
      }

      // Send the request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(responseBody);
        print('Response JSON: $responseJson');
        emit(UserEditProfileSuccess());

        // Save updated profile info in preferences
        preferences.setString(AppString.kName, event.name);
        preferences.setString(AppString.kPEmail, event.email);
        preferences.setString(AppString.kPPhoneNo, event.phone);
      } else {
        final responseJson = jsonDecode(responseBody);
        print('Failed to update profile: ${responseJson['message']}');
        emit(UserEditProfileFailure(responseJson['message'] ?? 'Unknown error occurred'));
      }
    } catch (error) {
      print('An error occurred: ${error.toString()}');
      emit(UserEditProfileFailure("An error occurred: $error"));
    }
  }

}