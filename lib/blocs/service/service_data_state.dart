// States
import 'package:power_washer/model/home_page_data_model.dart';
import 'package:power_washer/model/service_model.dart';

abstract class ServicePageState {}

class ServicePageInitial extends ServicePageState {}

class ServicePageLoading extends ServicePageState {}

class ServicePageLoaded extends ServicePageState {
  final ServiceModel serviceModel;

  ServicePageLoaded(this.serviceModel);
}

class ServicePageError extends ServicePageState {
  final String message;

  ServicePageError(this.message);
}