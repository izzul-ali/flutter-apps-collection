import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLogout()) {
    on<AuthEventLogin>(_onLogin);
    on<AuthEventLogout>(_onLogout);
  }

  Future<void> _onLogin(AuthEventLogin event, Emitter<AuthState> emit) async {
    try {
      emit(AuthStateLoading());

      final FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential user = await auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      debugPrint('login email: ${user.user?.email}');

      // store user data to localstorage

      emit(AuthStateLogin());
    } on FirebaseAuthException catch (e) {
      emit(AuthStateError(error: e.message.toString()));
    } catch (e) {
      emit(AuthStateError(error: e.toString()));
    }
  }

  Future<void> _onLogout(AuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthStateLoading());

      final FirebaseAuth auth = FirebaseAuth.instance;

      await auth.signOut();

      emit(AuthStateLogout());
    } on FirebaseAuthException catch (e) {
      emit(AuthStateError(error: e.message.toString()));
    } catch (e) {
      emit(AuthStateError(error: e.toString()));
    }
  }
}
