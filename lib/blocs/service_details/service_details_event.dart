
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// Events
abstract class ServiceDetailsEvent {}

class FetchServiceDetails extends ServiceDetailsEvent {}


class LoadServiceDetailsData extends ServiceDetailsEvent {
  /* String? userId;*/
  String serviceId;
  String latitude;
  String longitude;

  LoadServiceDetailsData(/*this.userId,*/this.serviceId,this.latitude,this.longitude,);

  @override
  List<Object> get props => [/*userId!*/serviceId,latitude,longitude,];
}

