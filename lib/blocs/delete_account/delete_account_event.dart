import 'package:equatable/equatable.dart';

abstract class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();

  @override
  List<Object> get props => [];
}

class DeleteAccountButtonPressed extends DeleteAccountEvent {
  const DeleteAccountButtonPressed();

  @override
  List<Object> get props => [];
}
