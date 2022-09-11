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
//  create SendMessageLoading state
class SendMessageLoading extends AuthState {}
//  create SendMessageSuccess state
class SendMessageSuccess extends AuthState {}
//  create SendMessageError state
class SendMessageError extends AuthState {
  final String error;
  SendMessageError(this.error);
}
//  create GetMessagesLoading state
class GetMessagesLoading extends AuthState {}
//  create GetMessagesSuccess state

class GetMessagesSuccess extends AuthState {
  //final List<Message> messages;
  //GetMessagesSuccess(this.messages);
}
//  create GetMessagesError state
class GetMessagesError extends AuthState {
  final String error;
  GetMessagesError(this.error);
}
//  create GetAllMessagesLoading
class GetAllMessagesLoading extends AuthState {}
//  create GetAllMessagesSuccess state
class GetAllMessagesSuccess extends AuthState {
  //final List<Message> messages;
  //GetAllMessagesSuccess(this.messages);
}
//  create GetAllMessagesError state
class GetAllMessagesError extends AuthState {
  final String error;
  GetAllMessagesError(this.error);
}
//  create SubscribeToTopicLoading state
class SubscribeToTopicLoading extends AuthState {}
//  create SubscribeToTopicSuccess state
class SubscribeToTopicSuccess extends AuthState {}
//  create UnsubscribeToTopicLoading state
class UnsubscribeToTopicLoading extends AuthState {}
//  create UnsubscribeToTopicSuccess state
class UnsubscribeToTopicSuccess extends AuthState {}
//  create UnsubscribeToTopicError state
class UnsubscribeToTopicError extends AuthState {
  final String error;
  UnsubscribeToTopicError(this.error);
}
//  create PostFcmTokenLoading state
class PostFcmTokenLoading extends AuthState {}
//  create PostFcmTokenSuccess state
class PostFcmTokenSuccess extends AuthState {}
//  create PostFcmTokenError state
class PostFcmTokenError extends AuthState {
  final String error;
  PostFcmTokenError(this.error);
}
//  create SendNotificationLoading state
class SendNotificationLoading extends AuthState {}
//  create SendNotificationSuccess state
class SendNotificationSuccess extends AuthState {}
//  create SendNotificationError state
class SendNotificationError extends AuthState {
  final String error;
  SendNotificationError(this.error);
}
//  create GetNotificationsLoading state
class GetNotificationsLoading extends AuthState {}
//  create GetNotificationsSuccess state
class GetNotificationsSuccess extends AuthState {
  //final List<Notification> notifications;
  //GetNotificationsSuccess(this.notifications);
}
//  create GetNotificationsError state
class GetNotificationsError extends AuthState {
  final String error;
  GetNotificationsError(this.error);
}
//  create GetAllNotificationsLoading state
class GetAllNotificationsLoading extends AuthState {}
//  create GetAllNotificationsSuccess state
class GetAllNotificationsSuccess extends AuthState {
  //final List<Notification> notifications;
  //GetAllNotificationsSuccess(this.notifications);
}
//  create GetAllNotificationsError state
class GetAllNotificationsError extends AuthState {
  final String error;
  GetAllNotificationsError(this.error);
}
//  create DeleteNotificationLoading state
class DeleteNotificationLoading extends AuthState {}
//  create DeleteNotificationSuccess state
class DeleteNotificationSuccess extends AuthState {}
//  create DeleteNotificationError state
class DeleteNotificationError extends AuthState {
  final String error;
  DeleteNotificationError(this.error);
}
//  create GetAllNotificationsCountLoading state
class GetAllNotificationsCountLoading extends AuthState {}
//  create GetUnreadNotificationsCountLoading state
class GetUnreadNotificationsCountLoading extends AuthState {}
//  create GetUnreadNotificationsCountSuccess state
class GetUnreadNotificationsCountSuccess extends AuthState {
  //final int unreadNotificationsCount;
  //GetUnreadNotificationsCountSuccess(this.unreadNotificationsCount);
}
//  create GetUnreadNotificationsCountError state
class GetUnreadNotificationsCountError extends AuthState {
  final String error;
  GetUnreadNotificationsCountError(this.error);
}
//  create SendFriendRequestLoading state
class SendFriendRequestLoading extends AuthState {}
//  create SendFriendRequestSuccess state
class SendFriendRequestSuccess extends AuthState {}
//  create SendFriendRequestError state
class SendFriendRequestError extends AuthState {
  final String error;
  SendFriendRequestError(this.error);
}
//  create GetFriendRequestsLoading state
class GetFriendRequestsLoading extends AuthState {}
//  create GetFriendRequestsSuccess state
class GetFriendRequestsSuccess extends AuthState {
  //final List<FriendRequest> friendRequests;
  //GetFriendRequestsSuccess(this.friendRequests);
}
//  create GetFriendRequestsError state
class GetFriendRequestsError extends AuthState {
  final String error;
  GetFriendRequestsError(this.error);
}
//  create AcceptFriendRequestLoading state
class AcceptFriendRequestLoading extends AuthState {}
//  create AcceptFriendRequestSuccess state
class AcceptFriendRequestSuccess extends AuthState {}
//  create AcceptFriendRequestError state
class AcceptFriendRequestError extends AuthState {
  final String error;
  AcceptFriendRequestError(this.error);
}
//  create GetAllFriendRequestsSuccess state
class GetAllFriendRequestsSuccess extends AuthState {
  //final List<FriendRequest> friendRequests;
  //GetAllFriendRequestsSuccess(this.friendRequests);
}
//  create GetAllFriendRequestsError state
class GetAllFriendRequestsError extends AuthState {
  final String error;
  GetAllFriendRequestsError(this.error);
}
//  create GetAllFriendRequestsLoading state
class GetAllFriendRequestsLoading extends AuthState {}
//  create DeleteFriendRequestLoading state/
class DeleteFriendRequestLoading extends AuthState {}
//  create DeleteFriendRequestSuccess state
class DeleteFriendRequestSuccess extends AuthState {}
//  create DeleteFriendRequestError state
class DeleteFriendRequestError extends AuthState {
  final String error;
  DeleteFriendRequestError(this.error);
}
//  create LikePostLoading state
class LikePostLoading extends AuthState {}
//  create LikePostSuccess state
class LikePostSuccess extends AuthState {}
//  create LikePostError state
class LikePostError extends AuthState {
  final String error;
  LikePostError(this.error);
}
//  create UnlikePostLoading state
class UnlikePostLoading extends AuthState {}
//  create UnlikePostSuccess state
class UnlikePostSuccess extends AuthState {}
//  create UnlikePostError state
class UnlikePostError extends AuthState {
  final String error;
  UnlikePostError(this.error);
}
//  create GetUserInfoLoading state
class GetUserInfoLoading extends AuthState {}
//  create GetUserInfoSuccess state
class GetUserInfoSuccess extends AuthState {
  //final User user;
  //GetUserInfoSuccess(this.user);
}
//  create GetUserInfoError state

class GetUserInfoError extends AuthState {
  final String error;
  GetUserInfoError(this.error);
}
//  create ResetPasswordLoading state
class ResetPasswordLoading extends AuthState {}
//  create ResetPasswordSuccess state
class ResetPasswordSuccess extends AuthState {}
//  create ResetPasswordError state
class ResetPasswordError extends AuthState {
  final String error;
  ResetPasswordError(this.error);
}
//  create SearchForUserLoading state
class SearchForUserLoading extends AuthState {}
//  create SearchForUserSuccess state
class SearchForUserSuccess extends AuthState {
  final List<SocialMediaUser> users;
  SearchForUserSuccess(this.users);
}
//  create SearchForUserError state
class SearchForUserError extends AuthState {
  final String error;
  SearchForUserError(this.error);
}
//  create ToggleSearchIconState state
class ToggleSearchIconState extends AuthState {}
//  create GetFriendsPostsLoading state
class GetFriendsPostsLoading extends AuthState {}
//  create GetFriendsPostsSuccess state
class GetFriendsPostsSuccess extends AuthState {
  //final List<Post> posts;
  //GetFriendsPostsSuccess(this.posts);
}
//  create GetFriendsPostsError state
class GetFriendsPostsError extends AuthState {
  final String error;
  GetFriendsPostsError(this.error);
}
//  create GetFriendsRequestLoading state
class GetFriendsRequestLoading extends AuthState {}
//  create GetFriendsRequestSuccess state
class GetFriendsRequestSuccess extends AuthState {
  //final List<FriendRequest> friendRequests;
  //GetFriendsRequestSuccess(this.friendRequests);
}
//  create GetFriendsRequestError state
class GetFriendsRequestError extends AuthState {
  final String error;
  GetFriendsRequestError(this.error);
}
//  create .GetFriendsNameLoading state
class GetFriendsNameLoading extends AuthState {}
//  create GetFriendsNameSuccess state
class GetFriendsNameSuccess extends AuthState {
  //final List<User> friends;
  //GetFriendsNameSuccess(this.friends);
}
//  create GetFriendsNameError state
class GetFriendsNameError extends AuthState {
  final String error;
  GetFriendsNameError(this.error);
}
//  create CurrentIndexChanged state
class CurrentIndexChanged extends AuthState {
  final int index;
  CurrentIndexChanged(this.index);
}
//  create UpdateProfileImageLoading state
class UpdateProfileImageLoading extends AuthState {}
//  create UpdateProfileImageSuccess state
class UpdateProfileImageSuccess extends AuthState {}
//  create UpdateProfileImageError state
class UpdateProfileImageError extends AuthState {
  final String error;
  UpdateProfileImageError(this.error);
}
//  create UpdateCoverImageLoading state
class UpdateCoverImageLoading extends AuthState {}
//  create UpdateCoverImageSuccess state
class UpdateCoverImageSuccess extends AuthState {}
//  create UpdateCoverImageError state
class UpdateCoverImageError extends AuthState {
  final String error;
  UpdateCoverImageError(this.error);
}
//  create GetLikesLoading state
class GetLikesLoading extends AuthState {}
//  create GetLikesSuccess state
class GetLikesSuccess extends AuthState {
  //final List<User> users;
  //GetLikesSuccess(this.users);
}
//  create GetLikesError state
class GetLikesError extends AuthState {
  final String error;
  GetLikesError(this.error);
}
//  create SetAllPostsIsLikedToFalseLoading state
class SetAllPostsIsLikedToFalseLoading extends AuthState {}
//  create SetAllPostsIsLikedToFalseSuccess state
class SetAllPostsIsLikedToFalseSuccess extends AuthState {}
//  create SetAllPostsIsLikedToFalseError state
class SetAllPostsIsLikedToFalseError extends AuthState {
  final String error;
  SetAllPostsIsLikedToFalseError(this.error);
}
//  create GetPendingFriendRequestsCountLoading state
class GetPendingFriendRequestsCountLoading extends AuthState {}
//  create GetPendingFriendRequestsCountSuccess state
class GetPendingFriendRequestsCountSuccess extends AuthState {
  //final int count;
  //GetPendingFriendRequestsCountSuccess(this.count);
}
//  create GetPendingFriendRequestsCountError state
class GetPendingFriendRequestsCountError extends AuthState {
  final String error;
  GetPendingFriendRequestsCountError(this.error);
}
//  create GetProfileAndCoverLoading state
class GetProfileAndCoverLoading extends AuthState {}
//  create GetProfileAndCoverSuccess state
class GetProfileAndCoverSuccess extends AuthState {
  //final String profileImage;
  //final String coverImage;
  //GetProfileAndCoverSuccess(this.profileImage, this.coverImage);
}
//  create GetProfileAndCoverError state
class GetProfileAndCoverError extends AuthState {
  final String error;
  GetProfileAndCoverError(this.error);
}
//  create GetValueProfileAndCoverError state
class GetValueProfileAndCoverError extends AuthState {
  final String error;
  GetValueProfileAndCoverError(this.error);
}
//  create GetProfileAndCoverLoading state
class GetValueProfileAndCoverCacheError extends AuthState {}
//  create GetProfileAndCoverSuccess state
class GetValueProfileAndCoverSuccess extends AuthState {
  //final String profileImage;
  //final String coverImage;
  //GetProfileAndCoverSuccess(this.profileImage, this.coverImage);
}
//  create GetProfileImageLoading state
class GetProfileImageLoading extends AuthState {}
//  create GetProfileImageSuccess state
class GetProfileImageSuccess extends AuthState {
  //final String profileImage;
  //GetProfileImageSuccess(this.profileImage);
}
//  create GetProfileImageError state
class GetProfileImageError extends AuthState {
  final String error;
  GetProfileImageError(this.error);
}
//  create GetCoverImageLoading state
class GetCoverImageLoading extends AuthState {}
//  create GetCoverImageSuccess state
class GetCoverImageSuccess extends AuthState {
  //final String coverImage;
  //GetCoverImageSuccess(this.coverImage);
}
//  create GetCoverImageError state
class GetCoverImageError extends AuthState {
  final String error;
  GetCoverImageError(this.error);
}



