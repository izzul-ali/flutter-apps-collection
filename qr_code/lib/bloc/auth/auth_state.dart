part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthStateLoading extends AuthState {}

final class AuthStateLogout extends AuthState {}

final class AuthStateLogin extends AuthState {
  // data user

  @override
  List<Object> get props => [];
}

final class AuthStateError extends AuthState {
  final String error;

  const AuthStateError({required this.error});

  @override
  List<Object> get props => [error];
}
