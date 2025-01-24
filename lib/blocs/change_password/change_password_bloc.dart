import 'package:bloc/bloc.dart';

import '../../repositary/api_repositary.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';
class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ApiService apiRepository;

  ChangePasswordBloc({required this.apiRepository})
      : super(ChangePasswordInitial()) {
    on<ChangePasswordSubmitted>((event, emit) async {
      emit(ChangePasswordLoading());
      try {
        // Call the API
        final response = await apiRepository.changePassword(
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
          confirmPassword: event.confirmPassword,
        );

        if (response['success'] == true) {
          print(response['message']);
          emit(ChangePasswordSuccess(message: response['message']));
        } else {
          print(response['message']);
          emit(ChangePasswordFailure(error: response['message']));
        }
      } catch (e) {
        print( e.toString());
        emit(ChangePasswordFailure(error: e.toString()));
      }
    });
  }
}
