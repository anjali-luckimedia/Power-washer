import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:power_washer/model/home_page_data_model.dart';
import 'package:power_washer/model/notification_model.dart';
import 'package:power_washer/model/review_model.dart';
import 'package:power_washer/model/search_model.dart';
import 'package:power_washer/model/service_model.dart';
import 'package:power_washer/model/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/my_request_model.dart';
import '../model/service_details_model.dart';
import '../utils/app_string.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime/mime.dart';
class ApiService {
  late SharedPreferences preferences;

  Future<HomeDataModel> fetchHomePageData() async {
    final response = await rootBundle.loadString('assets/json/home_data.json');
    final map = json.decode(response);
    print(jsonEncode(map)); // Convert the map to a JSON string for logging
    return HomeDataModel.fromJson(map);
  }

  Future<ServiceModel> fetchServiceData() async {
    final response =
        await rootBundle.loadString('assets/json/service_data.json');
    final map = json.decode(response);
    print(jsonEncode(map)); // Convert the map to a JSON string for logging
    return ServiceModel.fromJson(map);
  }
  Future<ServiceDetailsModel> fetchServiceDetailsData() async {
    final response =
    await rootBundle.loadString('assets/json/service_details.json');
    final map = json.decode(response);
    print(jsonEncode(map)); // Convert the map to a JSON string for logging
    return ServiceDetailsModel.fromJson(map);
  }
  Future<MyRequestModel> fetchMyRequestData() async {
    final response = await rootBundle.loadString('assets/json/my_request.json');
    final map = json.decode(response);
    print(jsonEncode(map)); // Convert the map to a JSON string for logging
    return MyRequestModel.fromJson(map);
  }
  //
  // Future<UserProfileModel> fetchUserData() async {
  //   final response = await rootBundle.loadString('assets/json/profile.json');
  //   final map = json.decode(response);
  //   print(jsonEncode(map)); // Convert the map to a JSON string for logging
  //   return UserProfileModel.fromJson(map);
  // }

  Future<UserProfileModel> fetchUserData() async {
    preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(AppString.kPrefUserIdKey);
    String? token = preferences.getString(AppString.kPrefToken);

    print('userId: $userId');
    print('Bearer: $token');

    try {
      final Uri uri = Uri.parse('${AppString.kBaseUrl}profile/get');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'user_id': userId,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 404) {
        final Map<String, dynamic> responseJson = json.decode(response.body);
       // print(responseJson.toString());
        return UserProfileModel.fromJson(responseJson);
      } else {
        print('Failed to load home page data with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load user profile data');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }
  Future<ReviewModel> fetchReviewData() async {
    final response =
    await rootBundle.loadString('assets/json/review_data.json');
    final map = json.decode(response);
    print(jsonEncode(map)); // Convert the map to a JSON string for logging
    return ReviewModel.fromJson(map);
  }

  Future<SearchModel> search(String query) async {
    final response =
        await rootBundle.loadString('assets/json/search_data.json');
    final map = json.decode(response);
    print(jsonEncode(map)); // Convert the map to a JSON string for logging
    return SearchModel.fromJson(map);
  }
  Future<NotificationModel> fetchNotification() async {
    final response = await rootBundle.loadString('assets/json/notification.json');
    final map = json.decode(response);
    print(jsonEncode(map)); // Convert the map to a JSON string for logging
    return NotificationModel.fromJson(map);
  }


  Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final url = Uri.parse('${AppString.kBaseUrl}password/change');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${preferences.getString(AppString.kPrefToken).toString()}'},
      body: {
        'user_id':preferences.getString(AppString.kPrefUserIdKey).toString(),
        'old_password': oldPassword,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return  json.decode(response.body);
      //throw Exception('Failed to change password');
    }
  }






}