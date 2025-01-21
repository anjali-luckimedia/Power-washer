
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// Events
abstract class ServiceDetailsEvent {}

class FetchServiceDetails extends ServiceDetailsEvent {}


class LoadServiceDetailsData extends ServiceDetailsEvent {
  /* String? userId;*/

  LoadServiceDetailsData(/*this.userId,*/ );

  @override
  List<Object> get props => [/*userId!*/];
}

