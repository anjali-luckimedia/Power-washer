import 'package:equatable/equatable.dart';
import 'package:power_washer/model/search_model.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
 SearchModel searchModel;

  SearchLoaded(this.searchModel);

  @override
  List<Object?> get props => [searchModel];
}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);

  @override
  List<Object?> get props => [error];
}
