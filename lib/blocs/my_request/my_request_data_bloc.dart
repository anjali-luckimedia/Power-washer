// BLoC



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/my_request/my_request_data_state.dart';
import 'package:power_washer/blocs/service/service_data_event.dart';
import 'package:power_washer/repositary/api_repositary.dart';

import 'my_request_data_event.dart';


class MyRequestPageBloc extends Bloc<MyRequestPageEvent, MyRequestPageState> {
  final ApiService apiService; // Inject the ApiMyRequest dependency
  MyRequestPageBloc(this.apiService) : super(MyRequestPageLoading()) {
    on<LoadMyRequestPageData>((event, emit) async {
      emit(MyRequestPageLoading());
      try {
        final myRequestModel = await apiService.fetchMyRequestData(/*userId: '1'*/);
        emit(MyRequestPageLoaded(myRequestModel));
      } catch (error) {
        emit(MyRequestPageError(error.toString()));
      }
    });

  }

}







