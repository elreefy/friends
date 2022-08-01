part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class FireBaseLoginInitial extends AuthState {}
//create a loading state
class FireBaseLoginLoading extends AuthState {}
//create a success state
class FireBaseLoginSuccess extends AuthState {}
//create a error state
class FireBaseLoginError extends AuthState {
  final String error;
  FireBaseLoginError(this.error);
}
//create a sign up loading state
class SignUpLoading extends AuthState {}
//create a sign up success state
class SignUpSuccess extends AuthState {}
//create a sign up error state
class SignUpError extends AuthState {
  final String error;
  SignUpError(this.error);
}
//create a toggle success state
class ToggleSuccess extends AuthState {}
//create a google sign in loading state
class GoogleSignInLoading extends AuthState {}
//create a google sign in success state
class GoogleLoginSuccess extends AuthState {}
//create a google sign in error state
class GoogleLoginError extends AuthState {
  final String error;
  GoogleLoginError(this.error);
}
