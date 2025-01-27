import 'package:equatable/equatable.dart';

abstract class AddReviewEvent extends Equatable {
  const AddReviewEvent();

  @override
  List<Object> get props => [];
}

class AddReviewButtonPressed extends AddReviewEvent {

  final String serviceId;
  final Set<int> categories;
  final String ratings;
  final String message;
  const AddReviewButtonPressed({required this.serviceId,required this.categories,required this.ratings, required this.message, });

  @override
  List<Object> get props => [serviceId,categories,ratings,message];
}
