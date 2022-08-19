part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {}
//create a class for getUserDataLoading
class GetUserDataLoading extends SocialState {}
//create a class for getUserDataSuccess
class GetUserDataSuccess extends SocialState {

}
//create a class for getUserDataError
class GetUserDataError extends SocialState {
  final String error;
  GetUserDataError(this.error);
}
//create a class for sendVerificationCodeLoading
class SendVerificationCodeLoading extends SocialState {}
//create a class for sendVerificationCodeSuccess
class SendVerificationCodeSuccess extends SocialState {}
//create a class for sendVerificationCodeError
class SendVerificationCodeError extends SocialState {
  final String error;
  SendVerificationCodeError(this.error);
}
//create a class for CurrentIndexChanged
class CurrentIndexChanged extends SocialState {
  final int currentIndex;
  CurrentIndexChanged({required this.currentIndex});
}
