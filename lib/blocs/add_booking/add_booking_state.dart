import 'package:equatable/equatable.dart';

abstract class AddBookingState extends Equatable {
  const AddBookingState();

  @override
  List<Object> get props => [];
}

class AddBookingInitial extends AddBookingState {}

class AddBookingLoading extends AddBookingState {}

class AddBookingSuccess extends AddBookingState {}

class AddBookingFailure extends AddBookingState {
  final String error;

  const AddBookingFailure(this.error);

  @override
  List<Object> get props => [error];
}
