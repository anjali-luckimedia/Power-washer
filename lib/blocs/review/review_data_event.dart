
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// Events
abstract class ReviewEvent {}

class FetchReview extends ReviewEvent {}


class LoadReviewData extends ReviewEvent {
  /* String? userId;*/

  LoadReviewData(/*this.userId,*/ );

  @override
  List<Object> get props => [/*userId!*/];
}

