import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:power_washer/model/home_page_data_model.dart';

class ApiService{
  Future<HomeDataModel> fetchHomePageData() async {
    final response = await rootBundle.loadString('assets/json/home_data.json');
    final map = json.decode(response);
    print(jsonEncode(map)); // Convert the map to a JSON string for logging
    return HomeDataModel.fromJson(map);
  }
}