part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class FireBaseLoginInitial extends AuthState {}
//create a loading state
class FireBaseLoginLoading extends AuthState {}
//create a success state
class FireBaseLoginSuccess extends AuthState {
  final String uId;
  FireBaseLoginSuccess(this.uId);
}
//create a error state
class FireBaseLoginError extends AuthState {
  final String error;
  FireBaseLoginError(this.error);
}
//create a sign up loading state
class SignUpLoading extends AuthState {}
//create a sign up success state
class SignUpSuccess extends AuthState {
  final String uId;
  SignUpSuccess(this.uId);
}
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
class GoogleLoginSuccess extends AuthState {
  final String uId;
  GoogleLoginSuccess(this.uId);

}
//create a google sign in error state
class GoogleLoginError extends AuthState {
  final String error;
  GoogleLoginError(this.error);
}
//create UserCreateLoading state
class UserCreateLoading extends AuthState {}
//create UserCreateSuccess state
class UserCreateSuccess extends AuthState {}
//create UserCreateError state
class UserCreateError extends AuthState {
  final String error;
  UserCreateError(this.error);
}
//create SendVerificationCodeLoading state
class SendVerificationCodeLoading extends AuthState {}
//create SendVerificationCodeSuccess state
class SendVerificationCodeSuccess extends AuthState {}
//create SendVerificationCodeError state
class SendVerificationCodeError extends AuthState {
  final String error;
  SendVerificationCodeError(this.error);
}
//create ImagePickerSuccess state
class ImagePickerSuccess extends AuthState {
}
//create ImagePickerError state
class ImagePickerError extends AuthState {
  final String error;
  ImagePickerError(this.error);
}
//create CoverPickerLoading state
class CoverPickerLoading extends AuthState {}
//create CoverImagePickerSuccess state
class CoverImagePickerSuccess extends AuthState {
  final File image;
  CoverImagePickerSuccess(this.image);
}
//create CoverImagePickerError state
class CoverImagePickerError extends AuthState {
  final String error;
  CoverImagePickerError(this.error);
}
//create UploadProfileImageLoading state
class UploadProfileImageLoading extends AuthState {}
//create UploadProfileImageSuccess state
class UploadProfileImageSuccess extends AuthState {
 // final String fileURL;
 // UploadProfileImageSuccess(this.fileURL);
}
//create UploadProfileImageError state
class UploadProfileImageError extends AuthState {
  final String error;
  UploadProfileImageError(this.error);
}
//create UploadCoverImageLoading state
class UploadCoverImageLoading extends AuthState {}
//create UploadCoverImageSuccess state
class UploadCoverImageSuccess extends AuthState {
}
//create UploadCoverImageError state
class UploadCoverImageError extends AuthState {
  final String error;
  UploadCoverImageError(this.error);
}
//create GetUserDataLoading state
class GetUserDataLoading extends AuthState {}
//create GetUserDataSuccess state
class GetUserDataSuccess extends AuthState {
  final User user;
  GetUserDataSuccess(this.user);
}
//create GetUserDataError state
class GetUserDataError extends AuthState {
  final String error;
  GetUserDataError(this.error);
}
//create UpdateUserDataLoading state
class UpdateUserLoading extends AuthState {}
//create UpdateUserDataSuccess state
class UpdateUserSuccess extends AuthState {}
//create UpdateUserDataError state
class UpdateUserError extends AuthState {
  final String error;
  UpdateUserError(this.error);
}
//create CreateNewPostLoading state
class CreateNewPostLoading extends AuthState {}
//create CreateNewPostSuccess state
class CreateNewPostSuccess extends AuthState {}
//create CreateNewPostError state
class CreateNewPostError extends AuthState {
  final String error;
  CreateNewPostError(this.error);
}
//create GetAllPostsLoading state
class GetAllPostsLoading extends AuthState {}
//create GetAllPostsSuccess state
class GetAllPostsSuccess extends AuthState {
}
//create GetAllPostsError state
class GetAllPostsError extends AuthState {
  final String error;
  GetAllPostsError(this.error);
}
//create UploadTextLoading state
class UploadTextLoading extends AuthState {}
//create UploadTextSuccess state
class UploadTextSuccess extends AuthState {}
//create UploadTextError state

class UploadTextError extends AuthState {
  final String error;
  UploadTextError(this.error);
}
//create deletePostLoading state
class DeletePostImageSuccess extends AuthState {}
//create GetPostLikesLoading state
class GetPostLikesLoading extends AuthState {}
//create GetPostLikesSuccess state
class GetPostLikesSuccess extends AuthState {
 // final List<String> likes;
 // GetPostLikesSuccess(this.likes);
}
//create GetPostLikesError state
class GetPostLikesError extends AuthState {
  final String error;
  GetPostLikesError(this.error);
}
//create CreatePostLikeSuccess state
class CreatePostLikeSuccess extends AuthState {}
//create CreatePostLikeError state
class CreatePostLikeError extends AuthState {
  final String error;
  CreatePostLikeError(this.error);
}
//create CreatePostLikeLoading state
class CreatePostLikeLoading extends AuthState {}
//create GetPostLikesCountSuccess state
class GetPostLikesCountSuccess extends AuthState {
  //final int likesCount;
  //GetPostLikesCountSuccess(this.likesCount);
}
//create GetPostLikesCountError state
class GetPostLikesCountError extends AuthState {
  final String error;
  GetPostLikesCountError(this.error);
}
//create GetPostCommentsLoading state
class GetPostLikesCountLoading extends AuthState {}
//  create GetAllUsersLoading state
class GetAllUsersLoading extends AuthState {}
//  create GetAllUsersSuccess state
class GetAllUsersSuccess extends AuthState {
  //final List<User> users;
 // GetAllUsersSuccess(this.users);
}
//  create GetAllUsersError state
class GetAllUsersError extends AuthState {
  final String error;
  GetAllUsersError(this.error);
}
