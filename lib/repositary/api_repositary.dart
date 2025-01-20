import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:power_washer/model/home_page_data_model.dart';
import 'package:power_washer/model/search_model.dart';
import 'package:power_washer/model/service_model.dart';
import 'package:power_washer/model/user_profile_model.dart';

import '../model/my_request_model.dart';

class ApiService {
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

  Future<MyRequestModel> fetchMyRequestData() async {
    final response = await rootBundle.loadString('assets/json/my_request.json');
    final map = json.decode(response);
    print(jsonEncode(map)); // Convert the map to a JSON string for logging
    return MyRequestModel.fromJson(map);
  }

  Future<UserProfileModel> fetchUserData() async {
    final response = await rootBundle.loadString('assets/json/profile.json');
    final map = json.decode(response);
    print(jsonEncode(map)); // Convert the map to a JSON string for logging
    return UserProfileModel.fromJson(map);
  }

  Future<SearchModel> search(String query) async {
    final response =
        await rootBundle.loadString('assets/json/search_data.json');
    final map = json.decode(response);
    print(jsonEncode(map)); // Convert the map to a JSON string for logging
    return SearchModel.fromJson(map);
  }
}