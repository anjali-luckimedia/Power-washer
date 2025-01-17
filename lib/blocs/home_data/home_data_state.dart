// States
import 'package:power_washer/model/home_page_data_model.dart';

abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final HomeDataModel homeDataModel;

  HomePageLoaded(this.homeDataModel);
}

class HomePageError extends HomePageState {
  final String message;

  HomePageError(this.message);
}