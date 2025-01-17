// BLoC



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/home_data/home_data_event.dart';
import 'package:power_washer/blocs/home_data/home_data_state.dart';
import 'package:power_washer/repositary/api_repositary.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final ApiService _apiService; // Inject the ApiService dependency
  HomePageBloc(this._apiService) : super(HomePageLoading()) {
    on<LoadHomePageData>((event, emit) async {
      emit(HomePageLoading());
      try {
        final notificationDataModel = await _apiService.fetchHomePageData(/*userId: '1'*/);
        emit(HomePageLoaded(notificationDataModel));
      } catch (error) {
        emit(HomePageError(error.toString()));
      }
    });

  }

}







