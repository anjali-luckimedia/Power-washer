import 'package:power_washer/model/search_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final SearchModel searchModel;

  SearchLoaded(this.searchModel);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
