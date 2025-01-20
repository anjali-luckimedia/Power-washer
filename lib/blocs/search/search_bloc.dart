import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/search/search_event.dart';
import 'package:power_washer/blocs/search/search_state.dart';
import 'package:power_washer/repositary/api_repositary.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiService _apiService; // Dependency injection for API service

  SearchBloc(this._apiService) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) async {
      if (event.query.isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());

      try {
        // Call the API to fetch search results
        final results = await _apiService.search(event.query);
        emit(SearchLoaded(results));
      } catch (error) {
        emit(SearchError(error.toString()));
      }
    });
  }
}
