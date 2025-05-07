import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/auth/bloc/auth_state.dart';
import '/features/auth/domain/usecases/is_logged_in.dart';
import '/service_locator.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(DisplayLoading());

  void appStarted() async {
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(UserAuthenticated());
    } else {
      emit(UserUnAuthenticated());
    }
  }
}
