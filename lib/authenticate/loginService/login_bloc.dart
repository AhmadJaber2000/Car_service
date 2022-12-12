import 'package:bloc/bloc.dart';
import 'login_event.dart';
import 'login_state.dart';



class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<ValidateLoginFieldsEvent>((event, emit) {
      if (event.key.currentState?.validate() ?? false) {
        event.key.currentState!.save();
        emit(ValidLoginFields());
      } else {
        emit(LoginFailureState(errorMessage: 'Please fill required fields.'));
      }
    });
  }
}
