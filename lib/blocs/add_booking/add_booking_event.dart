import 'package:equatable/equatable.dart';

abstract class AddBookingEvent extends Equatable {
  const AddBookingEvent();

  @override
  List<Object> get props => [];
}

class AddBookingButtonPressed extends AddBookingEvent {

  final String serviceId;
  final Set<int> categories;
  const AddBookingButtonPressed({required this.serviceId,required this.categories });

  @override
  List<Object> get props => [serviceId,categories];
}
