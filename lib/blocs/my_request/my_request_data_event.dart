
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// Events
abstract class MyRequestPageEvent {}

class FetchMyRequestPage extends MyRequestPageEvent {}


class LoadMyRequestPageData extends MyRequestPageEvent {
  /* String? userId;*/

  LoadMyRequestPageData(/*this.userId,*/ );

  @override
  List<Object> get props => [/*userId!*/];
}

