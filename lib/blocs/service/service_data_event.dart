
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// Events
abstract class ServicePageEvent {}

class FetchServicePage extends ServicePageEvent {}


class LoadServicePageData extends ServicePageEvent {
  /* String? userId;*/
  String latitude;
  String longitude;

  LoadServicePageData(/*this.userId,*/this.latitude,this.longitude);

  @override
  List<Object> get props => [/*userId!*/latitude,longitude];
}

