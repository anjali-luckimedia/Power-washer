// BLoC



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/service_details/service_details_event.dart';
import 'package:power_washer/blocs/service_details/service_details_state.dart';
import 'package:power_washer/repositary/api_repositary.dart';


class ServiceDetailsBloc extends Bloc<ServiceDetailsEvent, ServiceDetailsState> {
  final ApiService _apiService; // Inject the ApiService dependency
  ServiceDetailsBloc(this._apiService) : super(ServiceDetailsLoading()) {
    on<LoadServiceDetailsData>((event, emit) async {
      emit(ServiceDetailsLoading());
      try {
        final serviceDetailsModel = await _apiService.fetchServiceDetailsData(
            /*userId: '1'*/
            event.serviceId,event.latitude,event.longitude);
        emit(ServiceDetailsLoaded(serviceDetailsModel));
      } catch (error) {
        emit(ServiceDetailsError(error.toString()));
      }
    });

  }

}







