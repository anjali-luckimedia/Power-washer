// BLoC



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/service/service_data_event.dart';
import 'package:power_washer/repositary/api_repositary.dart';

import 'service_data_state.dart';

class ServicePageBloc extends Bloc<ServicePageEvent, ServicePageState> {
  final ApiService _apiService; // Inject the ApiService dependency
  ServicePageBloc(this._apiService) : super(ServicePageLoading()) {
    on<LoadServicePageData>((event, emit) async {
      emit(ServicePageLoading());
      try {
        final notificationDataModel = await _apiService.fetchServiceData(/*userId: '1'*/event.latitude,event.longitude);
        emit(ServicePageLoaded(notificationDataModel));
      } catch (error) {
        emit(ServicePageError(error.toString()));
      }
    });

  }

}







