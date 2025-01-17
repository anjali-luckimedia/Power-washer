
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// Events
abstract class HomePageEvent {}

class FetchHomePage extends HomePageEvent {}


class LoadHomePageData extends HomePageEvent {
  /* String? userId;*/

  LoadHomePageData(/*this.userId,*/ );

  @override
  List<Object> get props => [/*userId!*/];
}

