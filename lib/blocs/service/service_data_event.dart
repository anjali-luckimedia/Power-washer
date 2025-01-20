
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// Events
abstract class ServicePageEvent {}

class FetchServicePage extends ServicePageEvent {}


class LoadServicePageData extends ServicePageEvent {
  /* String? userId;*/

  LoadServicePageData(/*this.userId,*/ );

  @override
  List<Object> get props => [/*userId!*/];
}

