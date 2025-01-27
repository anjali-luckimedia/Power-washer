import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:power_washer/utils/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'add_review_event.dart';
import 'add_review_state.dart';

class AddReviewBloc extends Bloc<AddReviewEvent, AddReviewState> {
  AddReviewBloc() : super(AddReviewInitial()) {
    on<AddReviewButtonPressed>(_onAddReviewButtonPressed);
  }

  void _onAddReviewButtonPressed(AddReviewButtonPressed event, Emitter<AddReviewState> emit) async {
    emit(AddReviewLoading());

    // Initialize preferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(AppString.kPrefUserIdKey);
    String categories = event.categories.map((index) => (index).toString()).join(',');

    try {
      // Prepare request body
      final body = {
        'user_id': userId,
        'service_id': event.serviceId,
        'categories': categories,
        'ratings': event.ratings,
        'message': event.message,
      };

      print('Request body: $body');

      // Send POST request
      final http.Response response = await http.post(
        Uri.parse('${AppString.kBaseUrl}reviews/request'),
        headers: {
          'Authorization': 'Bearer ${preferences.getString(AppString.kPrefToken).toString()}',
        },
        body: body,
      );

      // Parse response
      var _responseData = json.decode(response.body.toString());


      if (_responseData['status'] == AppString.kSuccess) {
        print('Response from service: ${response.body}');
        emit(AddReviewSuccess());
      } else {
        emit(AddReviewFailure(_responseData['message']));
      }
    } catch (error) {
      emit(AddReviewFailure("An error occurred: $error"));
    }
  }
}
