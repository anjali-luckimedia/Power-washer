
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// Events
abstract class HomePageEvent {}

class FetchHomePage extends HomePageEvent {}


class LoadHomePageData extends HomePageEvent {
  /* String? userId;*/
  String latitude;
  String longitude;
  LoadHomePageData(/*this.userId,*/this.latitude,this.longitude);

  @override
  List<Object> get props => [/*userId!*/latitude,longitude];
}

