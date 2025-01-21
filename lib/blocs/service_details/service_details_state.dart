// States
import 'package:power_washer/model/home_page_data_model.dart';
import 'package:power_washer/model/service_details_model.dart';
import 'package:power_washer/model/service_model.dart';

abstract class ServiceDetailsState {}

class ServiceDetailsInitial extends ServiceDetailsState {}

class ServiceDetailsLoading extends ServiceDetailsState {}

class ServiceDetailsLoaded extends ServiceDetailsState {
  final ServiceDetailsModel serviceDetailsModel ;

  ServiceDetailsLoaded(this.serviceDetailsModel);
}

class ServiceDetailsError extends ServiceDetailsState {
  final String message;

  ServiceDetailsError(this.message);
}