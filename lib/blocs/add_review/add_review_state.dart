import 'package:equatable/equatable.dart';

abstract class AddReviewState extends Equatable {
  const AddReviewState();

  @override
  List<Object> get props => [];
}

class AddReviewInitial extends AddReviewState {}

class AddReviewLoading extends AddReviewState {}

class AddReviewSuccess extends AddReviewState {}

class AddReviewFailure extends AddReviewState {
  final String error;

  const AddReviewFailure(this.error);

  @override
  List<Object> get props => [error];
}
