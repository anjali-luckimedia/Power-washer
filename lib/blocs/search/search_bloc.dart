import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/search/search_event.dart';
import 'package:power_washer/blocs/search/search_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../model/search_model.dart';
import '../../utils/app_string.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<LoadSearchData>(_onSearchTextChanged);
  }

  Future<void> _onSearchTextChanged(
      LoadSearchData event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    final preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString(AppString.kPrefUserIdKey);
    final token = preferences.getString(AppString.kPrefToken);
    final latitude = preferences.get(AppString.kPLatitude)?.toString() ?? '0.0';
    final longitude =
        preferences.get(AppString.kPLongitude)?.toString() ?? '0.0';

    final bodyData = {
      'user_id': userId ?? '',
      'latitude': latitude,
      'longitude': longitude,
      'searchText': event.searchText ?? '',
      'miles': event.miles ?? '',
      'ratings': event.rating ?? '',
    };

    print('bodyData----$bodyData');

    try {
      final url = Uri.parse('${AppString.kBaseUrl}services/filter');
      final response = await http.post(
        url,
        body: bodyData,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final searchModel = SearchModel.fromJson(responseJson);
        emit(SearchLoaded(searchModel));
      } else {
        emit(SearchError('Failed to load search data'));
      }
    } catch (e) {
      emit(SearchError('Something went wrong: $e'));
    }
  }
}
