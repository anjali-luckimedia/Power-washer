// BLoC



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/review/review_data_state.dart';
import 'package:power_washer/blocs/service/service_data_event.dart';
import 'package:power_washer/repositary/api_repositary.dart';

import 'review_data_event.dart';


class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ApiService _apiService; // Inject the ApiService dependency
  ReviewBloc(this._apiService) : super(ReviewLoading()) {
    on<LoadReviewData>((event, emit) async {
      emit(ReviewLoading());
      try {
        final reviewModel = await _apiService.fetchReviewData(event.serviceId);
        emit(ReviewLoaded(reviewModel));
      } catch (error) {
        emit(ReviewError(error.toString()));
      }
    });

  }

}







