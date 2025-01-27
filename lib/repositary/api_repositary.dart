import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:power_washer/model/gallery_model.dart';
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
import 'dart:developer' as dev;

class ApiService {
  late SharedPreferences preferences;

  // Future<HomeDataModel> fetchHomePageData() async {
  //   final response = await rootBundle.loadString('assets/json/home_data.json');
  //   final map = json.decode(response);
  //   print(jsonEncode(map)); // Convert the map to a JSON string for logging
  //   return HomeDataModel.fromJson(map);
  // }
  Future<HomeDataModel> fetchHomePageData(String? lat, String? long) async {
    preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(AppString.kPrefUserIdKey);
    String? token = preferences.getString(AppString.kPrefToken);
    String?latitude;
    String?longitude;
    final latValue = preferences.get(AppString.kPLatitude);
    final longValue = preferences.get(AppString.kPLongitude);

    // Safely cast or convert to String
    latitude = latValue != null ? latValue.toString() : 'N/A';
    longitude = longValue != null ? longValue.toString() : 'N/A';
    print('userId: $userId');
    print('Bearer: $token');
    final bodyData = {
      'user_id': userId,
      'latitude': latitude,
      'longitude': longitude,
    };
    try {
      final Uri uri = Uri.parse('${AppString.kBaseUrl}home/index');
      final response = await http.post(
          uri,
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: bodyData
      );
      print('Body Data: $bodyData');
      if (response.statusCode == 200 || response.statusCode == 404) {
        // Parse the JSON response
        final responseJson = jsonDecode(response.body);

        dev.log(responseJson.toString());
        return HomeDataModel.fromJson(responseJson);
      } else {
        print('Failed to load home page data with status code: ${response.statusCode}');
        dev.log('Response body: ${response.body}');
        throw Exception('Failed to load user feedback data');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }


  Future<ServiceModel> fetchServiceData(String? lat, String? long) async {
    preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(AppString.kPrefUserIdKey);
    String? token = preferences.getString(AppString.kPrefToken);
    String?latitude;
    String?longitude;
    final latValue = preferences.get(AppString.kPLatitude);
    final longValue = preferences.get(AppString.kPLongitude);

    // Safely cast or convert to String
    latitude = latValue != null ? latValue.toString() : 'N/A';
    longitude = longValue != null ? longValue.toString() : 'N/A';
    print('userId: $userId');
    print('Bearer: $token');
    final bodyData = {
      'user_id': userId,
      'latitude': latitude,
      'longitude': longitude,
    };
    try {
      final Uri uri = Uri.parse('${AppString.kBaseUrl}services/index');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: bodyData
      );
      print('Body Data: $bodyData');
      if (response.statusCode == 200 || response.statusCode == 404) {
        // Parse the JSON response
        final responseJson = jsonDecode(response.body);

        dev.log(responseJson.toString());
        return ServiceModel.fromJson(responseJson);
      } else {
        print('Failed to load home page data with status code: ${response.statusCode}');
        dev.log('Response body: ${response.body}');
        throw Exception('Failed to load user feedback data');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }


  Future<MyRequestModel> fetchMyRequestData() async {
    preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(AppString.kPrefUserIdKey);
    String? token = preferences.getString(AppString.kPrefToken);

    print('userId: $userId');
    print('Bearer: $token');

    try {
      final Uri uri = Uri.parse('${AppString.kBaseUrl}booking/index');
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
        // Parse the JSON response
        final responseJson = jsonDecode(response.body);

        dev.log(responseJson.toString());
        return MyRequestModel.fromJson(responseJson);
      } else {
        print('Failed to load home page data with status code: ${response.statusCode}');
        dev.log('Response body: ${response.body}');
        throw Exception('Failed to load user feedback data');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }


  Future<ServiceDetailsModel> fetchServiceDetailsData(String? serviceId,String? lat, String? long) async {
    preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(AppString.kPrefUserIdKey);
    String? token = preferences.getString(AppString.kPrefToken);
    String?latitude;
    String?longitude;
    final latValue = preferences.get(AppString.kPLatitude);
    final longValue = preferences.get(AppString.kPLongitude);

    // Safely cast or convert to String
    latitude = latValue != null ? latValue.toString() : 'N/A';
    longitude = longValue != null ? longValue.toString() : 'N/A';
    print('userId: $userId');
    print('Bearer: $token');
    final bodyData = {
      'user_id': userId,
      'service_id': serviceId,
      'latitude': latitude,
      'longitude': longitude,
    };
    try {
      final Uri uri = Uri.parse('${AppString.kBaseUrl}services/details');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: bodyData
      );

      print('Body Data: $bodyData');

      if (response.statusCode == 200) {
        // Parse the JSON response
        final responseJson = jsonDecode(response.body);

        dev.log(responseJson.toString());
        return ServiceDetailsModel.fromJson(responseJson);
      } else {
        print('Failed to load service details page data with status code: ${response.statusCode}');
        dev.log('Response body: ${response.body}');
        throw Exception('Failed to load service details data');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }




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


  Future<ReviewModel> fetchReviewData(String? serviceId) async {
    preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(AppString.kPrefUserIdKey);
    String? token = preferences.getString(AppString.kPrefToken);
    print('userId: $userId');
    print('Bearer: $token');
    final bodyData = {
      'user_id': userId,
      'service_id': serviceId,
    };
    try {
      final Uri uri = Uri.parse('${AppString.kBaseUrl}reviews/index');
      final response = await http.post(
          uri,
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: bodyData
      );

      print('Body Data: $bodyData');

      if (response.statusCode == 200) {
        // Parse the JSON response
        final responseJson = jsonDecode(response.body);

        dev.log(responseJson.toString());
        return ReviewModel.fromJson(responseJson);
      } else {
        print('Failed to load service details page data with status code: ${response.statusCode}');
        dev.log('Response body: ${response.body}');
        throw Exception('Failed to load service details data');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }

  Future<GalleryModel> fetchGalleryData(String? serviceId) async {
    preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(AppString.kPrefUserIdKey);
    String? token = preferences.getString(AppString.kPrefToken);
    print('userId: $userId');
    print('Bearer: $token');
    final bodyData = {
      'user_id': userId,
      'service_id': serviceId,
    };
    try {
      final Uri uri = Uri.parse('${AppString.kBaseUrl}services/gallery');
      final response = await http.post(
          uri,
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: bodyData
      );

      print('Body Data: $bodyData');

      if (response.statusCode == 200) {
        // Parse the JSON response
        final responseJson = jsonDecode(response.body);

        dev.log(responseJson.toString());
        return GalleryModel.fromJson(responseJson);
      } else {
        print('Failed to load service details page data with status code: ${response.statusCode}');
        dev.log('Response body: ${response.body}');
        throw Exception('Failed to load service details data');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }

  Future<SearchModel> search(String? query, String? miles, String? rating) async {
    final preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString(AppString.kPrefUserIdKey);
    final token = preferences.getString(AppString.kPrefToken);
    final latitude = preferences.get(AppString.kPLatitude)?.toString() ?? 'N/A';
    final longitude = preferences.get(AppString.kPLongitude)?.toString() ?? 'N/A';

    final bodyData = {
      'user_id': userId,
      'latitude': latitude,
      'longitude': longitude,
      'searchText': query,
      'miles': miles,
      'ratings': rating,
    };

    try {
      final uri = Uri.parse('${AppString.kBaseUrl}services/filter');
      final response = await http.post(
        uri,
        headers: {'Authorization': 'Bearer $token'},
        body: bodyData,
      );

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        return SearchModel.fromJson(responseJson);
      } else {
        throw Exception('Failed to load search data');
      }
    } catch (error) {
      throw error;
    }
  }

  // Future<SearchModel> search(String query) async {
  //   final response =
  //       await rootBundle.loadString('assets/json/search_data.json');
  //   final map = json.decode(response);
  //   print(jsonEncode(map)); // Convert the map to a JSON string for logging
  //   return SearchModel.fromJson(map);
  // }



  Future<NotificationModel> fetchNotification() async {
    preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(AppString.kPrefUserIdKey);
    String? token = preferences.getString(AppString.kPrefToken);
    print('userId: $userId');
    print('Bearer: $token');
    final bodyData = {
      'user_id': userId,
    };
    try {
      final Uri uri = Uri.parse('${AppString.kBaseUrl}notification/index');
      final response = await http.post(
          uri,
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: bodyData
      );

      print('Body Data: $bodyData');

      if (response.statusCode == 200) {
        // Parse the JSON response
        final responseJson = jsonDecode(response.body);

        dev.log(responseJson.toString());
        return NotificationModel.fromJson(responseJson);
      } else {
        print('Failed to load service details page data with status code: ${response.statusCode}');
        dev.log('Response body: ${response.body}');
        throw Exception('Failed to load service details data');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
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