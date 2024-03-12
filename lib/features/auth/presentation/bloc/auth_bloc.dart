import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/core/common/cubit/cubit/app_user_cubit.dart';
import 'package:music_app/core/usecase/usecase.dart';
import 'package:music_app/features/auth/domain/usecases/current_user.dart';
import 'package:music_app/features/auth/domain/usecases/user_log_in.dart';
import 'package:music_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:music_app/core/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) => emit(AuthLoading()),
    );

    on<AuthSignUp>(_onAuthsignUp);

    on<AuthLogin>(_onAuthLogin);

    on<AuthIsUserLoggedIn>(_isUserLoggedin);
  }

  void _onAuthsignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(SignupParams(
        email: event.email, name: event.name, password: event.password));

    res.fold((failure) => emit(AuthFailure(message: failure.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  void _isUserLoggedin(AuthEvent event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
