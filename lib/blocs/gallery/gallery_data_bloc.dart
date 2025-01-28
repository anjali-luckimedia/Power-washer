// BLoC



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/gallery/gallery_data_event.dart';
import 'package:power_washer/blocs/gallery/gallery_data_state.dart';
import 'package:power_washer/repositary/api_repositary.dart';




class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final ApiService _apiService; // Inject the ApiService dependency
  GalleryBloc(this._apiService) : super(GalleryLoading()) {
    on<LoadGalleryData>((event, emit) async {
      emit(GalleryLoading());
      try {
        final reviewModel = await _apiService.fetchGalleryData(event.serviceId);
        emit(GalleryLoaded(reviewModel));
      } catch (error) {
        emit(GalleryError(error.toString()));
      }
    });

  }

}







