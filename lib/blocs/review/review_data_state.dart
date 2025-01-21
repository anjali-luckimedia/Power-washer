// States
import 'package:power_washer/model/home_page_data_model.dart';
import 'package:power_washer/model/review_model.dart';
import 'package:power_washer/model/service_model.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final ReviewModel reviewModel;

  ReviewLoaded(this.reviewModel);
}

class ReviewError extends ReviewState {
  final String message;

  ReviewError(this.message);
}