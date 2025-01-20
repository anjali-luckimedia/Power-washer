// States
import 'package:power_washer/model/home_page_data_model.dart';
import 'package:power_washer/model/my_request_model.dart';
import 'package:power_washer/model/service_model.dart';

abstract class MyRequestPageState {}

class MyRequestPageInitial extends MyRequestPageState {}

class MyRequestPageLoading extends MyRequestPageState {}

class MyRequestPageLoaded extends MyRequestPageState {
  final MyRequestModel myRequestModel;

  MyRequestPageLoaded(this.myRequestModel);
}

class MyRequestPageError extends MyRequestPageState {
  final String message;

  MyRequestPageError(this.message);
}