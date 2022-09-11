import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:friends/data/api/dio_helper.dart';

import 'package:path/path.dart' as Path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/data/cashe_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/FriendRequestModel.dart';
import '../../data/models/Message.dart';
import '../../data/models/NotificationModel.dart';
import '../../data/models/SocialMediaUser.dart';
import '../../data/models/post_model.dart';
import '../../shared/constants/strings.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  //create email controller and password controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var bioEditingController=TextEditingController();
  var nameEditingController=TextEditingController();
  var passwordEditingController=TextEditingController();
  var postController = TextEditingController();
  var messageEditingController= TextEditingController();
  var searchController= TextEditingController();
  var textEditingController= TextEditingController();
  var commentEditingController = TextEditingController();


  AuthCubit() : super(FireBaseLoginInitial());

  bool isPasswordVisible=true;
  bool isSearching=false;

  var formKey = GlobalKey<FormState>();

  static AuthCubit get(context) => BlocProvider.of(context);
//toggle search icon
  void toggleSearchIcon(){
    isSearching=!isSearching;
    emit(ToggleSearchIconState());
  }
  //take the user and password and check if they are correct using firebase
  //if they are correct then move to the next screen
  //if they are not correct then show error message
  void login({required String user, required String password}) {
    emit(FireBaseLoginLoading());
  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user, password: password)
      .then((value) {
    //4    print(value.user!.uid);
    //    print(value.user!.email);
        emit(FireBaseLoginSuccess(value.user!.uid));
      }).catchError((error) {
        emit(FireBaseLoginError(error.toString()));
        print('EROOOOOOORRRRR HERE:::'+error.toString());
      });
    // Future.delayed(const Duration(seconds: 1), () {
    // });
  }
  //create a sign up function that will take the user and password and phone number and create a new user in firebase
  //if the user is created then move to the next screen
  //if the user is not created then show error message
  void signUp({
    required String user,
    required String password,
    required phoneNumber,
    required userName,
  }) {
     emit(SignUpLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email:    user,
        password: password,
    )
        .then((value) {
      userCreate(
        profileImage:'https://i.pinimg.com/736x/68/a5/aa/68a5aa104457ecac4d4136285a830e3e.jpg',
       isVerifcationSend: false,
        password: password,
        user: user,
        uid: value.user!.uid,
        phoneNumber: phoneNumber,
        userName: userName,
      );
      subscribeToTopic(topic: 'announcements');
          print(value.user!.email);
          emit(
              SignUpSuccess(
              value.user!.uid
              )
              );
          //save the user uid to the cache
          CashHelper.setString(
              key:'uId' , value: value.user!.uid);
        }).catchError((error) {
      emit(SignUpError(error.toString()));
      print(error.toString());
    });
  }
  //model for the user
  SocialMediaUser? socialMediaUser;
  //create a function that will take the user and password and phone number and create a new user in firebase using social media user model
  //if the user is created then move to the next screen
  //if the user is not created then show error message
  void userCreate({
    required String profileImage,
    required String password,
    required String user,
    String? phoneNumber,
    required String uid,
    required bool isVerifcationSend, String? userName,
  }) {
    emit(UserCreateLoading());
    socialMediaUser = SocialMediaUser(
      coverImage:firstCoverImage,
      profileImage: profileImage??'https://i.pinimg.com/736x/68/a5/aa/68a5aa104457ecac4d4136285a830e3e.jpg',
      bio: 'write biooo',
      email: user,
      uid: uid,
      deviceToken://get the device token from the cache
          CashHelper.getString('deviceToken'),
      name:  userName??'reefy',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(socialMediaUser!.toJson())
        .then((value) {

          print('USER CREATED mbrooooooooooooooooooooooooooooook'
           );
      //print socail media user
      print(socialMediaUser!.toJson());
      emit(UserCreateSuccess());
    }).catchError((error) {
      emit(UserCreateError(error));
      print(error.toString());
    });
  }
  //get user post using snapshots


  //get user info by using uid and safe it in socialMediaUser
  Future<void> getUserInfo(String uid) async {
    emit(GetUserInfoLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      socialMediaUser = SocialMediaUser.fromJson(value.data());
      emit(GetUserInfoSuccess());
    }).catchError((error) {
      emit(GetUserInfoError(error));
      print(error.toString());
    });
  }
  int currentIndex = 0;
  void changeCurrentIndex(int index) {
    currentIndex = index;
    print(currentIndex);
    emit(CurrentIndexChanged(currentIndex));
  }
  // userCreate(
  //     {
  //       required String uid,
  //       required String user,
  //       required String password,
  //       required String profileImage,
  //       required bool isVerifcationSend,
  //       String? phoneNumber,
  //     }
  //     )
  // {
  //   emit(UserCreateLoading());
  //   FirebaseFirestore.instance
  //      .collection('users')
  //   .doc(uid).set({
  //     'email': user,
  //     'password': password,
  //     'phoneNumber': phoneNumber,
  //     'isVerifcationSend': isVerifcationSend,
  //     'profileImage' : profileImage,
  //
  //   }
  // ).then((value) {
  //     emit(UserCreateSuccess());
  //   }).catchError((error) {
  //     emit(UserCreateError(error.toString()));
  //     print(error.toString());
  //   });
  //
  // }


  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(ToggleSuccess());
  }
  //create a logout function that will log the user out of firebase
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleUser;
  //method to sign in with google and stay logged in
  Future<void> signInWithGoogle() async {
    emit(FireBaseLoginLoading());
    googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      emit(GoogleLoginError('Google sign in failed'));
      return;
    }
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
     print('google sign i \n\n\n\n\n\n');
     print(authResult.user!.uid);
     //save the user uid to the cache
      CashHelper.setString(
          key:'uId' , value: authResult.user!.uid);
     print(authResult.user!.email);
      print(authResult.user!.displayName);
      print(authResult.user!.photoURL);
      userCreate(
          profileImage: authResult.user!.photoURL!,
          isVerifcationSend: false,
          password: '123456',
          user: authResult.user!.email!,
          uid: authResult.user!.uid,
          userName: authResult.user!.displayName
      );
    emit(GoogleLoginSuccess(authResult.user!.uid));
  }
//logout of google
  void signOut() async{
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    uId = null;
    //clear uid from cashe helper
    CashHelper.clearString(
        key: 'uId',
    );
    currentIndex = 0;
    // emit(FireBaseLoginInitial());
  }
  //send verification code to email address using firebase auth and firebase firestore
  void sendVerificationCode() {
    emit(SendVerificationCodeLoading());
    FirebaseAuth.instance.currentUser!.sendEmailVerification()
        .then((value) {
      emit(SendVerificationCodeSuccess());
    }).catchError((error) {
      emit(SendVerificationCodeError(error.toString()));
    });
  }
  File? profileImage;
  File? postImage;
  File? commentImage;
  //  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  final ImagePicker _picker = ImagePicker();
  // Pick an image
  // Capture a photo
  Future getImageFromGallery(
      {int typeOfImage=0}
      ) async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if(typeOfImage==0){
        profileImage = File(pickedFile.path);
      }else if(typeOfImage==1){
        postImage = File(pickedFile.path);
      }
      else if(typeOfImage==2){
        commentImage = File(pickedFile.path);
      }
      emit(ImagePickerSuccess());
    }else{
      print('no image');
      emit(ImagePickerError('no image'));
    }
  }
  
  File? coverImage;
  //  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  final ImagePicker picker = ImagePicker();
  // Pick an image
  // Capture a photo
  getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(coverImage);
      emit(CoverImagePickerSuccess(coverImage!));
    }else{
      print('no image');
      emit(CoverImagePickerError('no image'));
    }
  }
  String? profileImageUrl=firstProfileImage;
 Future<void> uploadProfileImage({required File image}) async {
   emit(UploadProfileImageLoading());
   Reference storageReference = FirebaseStorage.instance.ref().child(
       'users/${
           Uri
           .parse(image.path)
           .pathSegments
           .last}'
   );
   UploadTask uploadTask = storageReference.putFile(image);
   emit(UploadProfileImageSuccess());
   await uploadTask.then((value) {
     print('File Uploaded');
     storageReference.getDownloadURL().then((fileURL) {
       print(' PROFILE IMAGE URLLLL '+fileURL);
       profileImageUrl = fileURL;
       socialMediaUser?.profileImage = fileURL;
       FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).
       update({
          'profileImage': fileURL,
     });
     emit(UploadProfileImageSuccess());
   }).catchError((error) {
     emit(UploadProfileImageError(error.toString()));
     print('errror' + error.toString());
      });
   });
 }
  String coverImageUrl=firstCoverImage;
 //upload cover image
  Future<void> uploadCoverImage({required File image}) async {
    emit(UploadCoverImageLoading());
    Reference storageReference = FirebaseStorage.instance.ref().child(
        'users/${
            Uri
            .parse(image.path)
            .pathSegments
            .last}'
    );
    UploadTask uploadTask = storageReference.putFile(image);
    emit(UploadCoverImageSuccess(
    ));
    await uploadTask.then((value) {
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        print(' COVER IMAGE URLLLL '
            '\n'
            '\n'
            '\n'
            '\n'
            '\n'
            ''+fileURL);
        coverImageUrl = fileURL;
        socialMediaUser?.coverImage = fileURL;
        FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).
        update({
           'coverImage': fileURL,
    });
    emit(UploadCoverImageSuccess());
  }).catchError((error) {
    emit(UploadCoverImageError(error.toString()));
    print('errror' + error.toString());
     });
  }).catchError((error) {
    emit(UploadCoverImageError(error.toString()));
    print('errror' + error.toString());
  });
  }

  //update user using Social User model
  void updateUser({
     String? uid,
    required String bio,
    required String user,
    required String phone,
     bool? isVerifcationSend,
    String? phoneNumber
  }) {
    emit(UpdateUserLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(socialMediaUser!.uid)
        .update({
         'bio': bio,
         'name': user,
         'phone': phone,
    }
    ).then((value) {
          //get user data from firebase firestore
         getUserInfo(socialMediaUser!.uid!);
      emit(UpdateUserSuccess());
      print(FirebaseAuth.instance.currentUser!.uid);
    }).catchError((error) {
      emit(UpdateUserError(error.toString()));
      print(error.toString());
    });
  }
  //
  // void uploadProfileImage(
  //     {required File image}
  //     ) {
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child(Uri.file(image.path).pathSegments.last)
  //       .putFile(image)
  //       .then((value) {
  //     // value.ref.getDownloadURL().then((value) {
  //     //   updateUserData(
  //     //       name: name,
  //     //       phone: phone,
  //     //       bio: bio,
  //     //       coverImage: coverImage,
  //     //       profileImage: value);
  //     //   emit(UploadProfileImageSuccess());
  //     // }).catchError((error) {
  //     //   print(error.toString());
  //     //   emit(UploadProfileImageError(
  //     //       error.toString()));
  //     // });
  //     emit(UploadProfileImageSuccess());
  //   }).catchError((error) {
  //     print('deeh il moshkelaaaa'+error.toString());
  //     emit(UploadProfileImageError(
  //         error.toString()));
  //   });
  // }
//create new posts without image
  String? postImageUrl;
  //upload image
  Post? postModel;
  Future createNewPost({required String post,
    required File postImage,
    required String name, required String senderId
  })  async{
   var postId=Uuid().v4();
    emit(CreateNewPostLoading());
    Reference storageReference = FirebaseStorage.instance.ref().child(
        'posts/${
            Uri
            .parse(postImage.path)
            .pathSegments
            .last}'
    );
      UploadTask uploadTask = storageReference.putFile(postImage);
      await uploadTask.then((value) {
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        print(' POST IMAGE URLLLL '+fileURL);
        postImageUrl = fileURL;
         postModel = Post(
          postImage: fileURL,
          isLiked: false,
          likes: 0,
          uId: uId,
          post: post,
          dateTime:FieldValue.serverTimestamp(),
          profilePicture: socialMediaUser?.profileImage??firstProfileImage,
          postId: postId,
          name: name,
          date: Timestamp.now(),
        );

        emit(CreateNewPostSuccess());
        print(' post image url '+postImageUrl!);
      }).then((value) =>{
      FirebaseFirestore.instance.collection('posts').doc(postId).
      set(
      postModel!.toMap(),
      ),
      emit(CreateNewPostSuccess()),
      }).catchError((error) {
        emit(CreateNewPostError(error.toString()));
        print('errror' + error.toString());
         });
    }).catchError((error) {
      emit(CreateNewPostError(error.toString()));
      print('errror' + error.toString());
    });
  }
  //upload text to firebase firestore
  Future uploadText({
    required String post,
    required String name,
    String? senderId,
  }) async {
    var postId=Uuid().v4();
    emit(UploadTextLoading());
    Post postModel = Post(
      isLiked: false,
      likes: 0,
      uId: uId,
      postImage: null,
      post: post,
      dateTime:FieldValue.serverTimestamp(),
      profilePicture: socialMediaUser?.profileImage??firstProfileImage,
      postId: postId,
      name: name,
      date: Timestamp.now(),

    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId).
    set(
       postModel.toMap(),
    ).then((value) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(uId).
      set(
          {
            'isLiked': false,
          }
      );
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('posts')
        .doc(postId).
    set(
       postModel.toMap(),
    );
    emit(UploadTextSuccess());
  }
  //TODO:3ayez ageeb id il gd3 ely 3ndy fel 2sdeqa2 w 2 2qarnh b id elly ba3et il post
//get friends request name where status is accepted and store in list
  List<String> friendsRequestName=[];
  void getFriendsName() {
    emit(GetFriendsNameLoading());
   // emit(GetFriendsRequestLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('friendsRequest')
        .where('status', isEqualTo: 'accepted')
        .get()
        .then((value) {
      print('friendsRequest\n' + friendsRequestName.toString());
      value.docs.forEach((element) {
        friendsRequestName.add(element['senderEmail']);
      });
      emit(GetFriendsNameSuccess());
    //  emit(GetFriendsRequestSuccess());
    }).catchError((error) {
      emit(GetFriendsNameError(error.toString()));
     // emit(GetFriendsRequestError(error.toString()));
    });
  }


  //get all my friends posts where id is in my friends list
  List<Post> posts = [];
  Future<void> getAllPosts() async{
    emit(GetAllPostsLoading());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((data) {
       posts = data.docs.map((doc) {
        return Post.fromJson(doc.data());
      }).toList();
      emit(GetAllPostsSuccess());
    }).onError((error) {
      emit(GetAllPostsError(error.toString()));
    });
  }
 //get if user like post or not

  int postLikesCount = 0;
   getPostLikesCount({required String postId}) {
    emit(GetPostLikesCountLoading());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .get()
        .then((value) {
      postLikesCount = value.docs.length;
      emit(GetPostLikesCountSuccess());
    }).catchError((error) {
      emit(GetPostLikesCountError(error.toString()));
    });
  }


  //post likes
  List<Post> postLikes = [];
  void getPostLikes({required String postId}) {
    emit(GetPostLikesLoading());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .snapshots()
        .listen((data) {
      postLikes = data.docs.map((doc) {
        return Post.fromJson(doc.data());
      }).toList();
       print('post likesssssssSSSss '+postLikes.length.toString());
    print('post likesssssssSSSss ');
      emit(GetPostLikesSuccess());
    }).onError((error) {
      emit(GetPostLikesError(error.toString()));
    });
  }
  //create post likes
  void createPostLike({required String postId}) {
    emit(CreatePostLikeLoading());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(uId)
        .set({
       'likes': true,
      }).then((value) =>{
      emit(CreatePostLikeSuccess()),
      getPostLikesCount(postId: postId),
    }
      ).catchError((error) {
      emit(CreatePostLikeError(error.toString()));
       print('errror' + error.toString());
    });
  }
//like post and add 1 to likes
  Future<void> likePost({required String postId}) async {
    emit(LikePostLoading());
   //print is liked before like
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(FirebaseAuth.instance.currentUser!.uid).
    set(
        {
          'isLiked': true,
        }
    ).then((value) {
      getIsLiked(postId: postId).then((value){
        FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({
          'likes': FieldValue.increment(1),
           'isLiked': value,
        }).then((value) =>{
          emit(LikePostSuccess()),
        }
        ).catchError((error) {
          emit(LikePostError(error.toString()));
          print('errror' + error.toString());
        });
      });
    });
  }
  //set all posts is liked to false
  Future<void> setAllPostsIsLiked() async {
    emit(SetAllPostsIsLikedToFalseLoading());
    await FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
       await getIsLiked(postId: element.id).then((value){
          print('is liked final\n\n\n\n'+value.toString());
          print('id\n\n\n\n'+element.id.toString());
          //if is liked is null set it to false
          if(value==null){
            FirebaseFirestore.instance
                .collection('posts')
                .doc(element.id)
                .update({
              'isLiked': false,
            });
          }else
            {
              FirebaseFirestore.instance
                  .collection('posts')
                  .doc(element.id)
                  .update(
                  {
                    'isLiked': value,
                  }
              );
            }
          emit(SetAllPostsIsLikedToFalseSuccess());
        });
       emit(SetAllPostsIsLikedToFalseSuccess());
      });
    }).catchError((error) {
      emit(SetAllPostsIsLikedToFalseError(error.toString()));
      print('errror' + error.toString());
    });
  }
  bool isLiked = false;
  Future<bool> getIsLiked(
      {
        required String postId
       }
      ) async {
    emit(GetAllNotificationsLoading());
   await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes').
         doc(FirebaseAuth.instance.currentUser!.uid).
         get().then((data) {
      print('getIsLiked \n\n\n\n\n\n\n');
      print(data.data());
      print( data.data()?['isLiked']);
      emit(GetAllNotificationsSuccess());
      //if is liked is null set it to false
      if(data.data()?['isLiked'] == null) {
        isLiked = false;
      }else{
        isLiked = data.data()?['isLiked'];
      }
    });
    return isLiked;
  }


//unlike post and subtract 1 from likes count
  void unlikePost({required String postId}) {
    emit(UnlikePostLoading());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(uId).
    set(
        {
          'isLiked': false,
        }
    ).then((value) {
      getIsLiked(postId: postId).then((value) {
        FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({
          'likes': FieldValue.increment(-1),
          'isLiked': value,
        }).then((value) =>{
          emit(UnlikePostSuccess()),
          getPostLikesCount(postId: postId),
        }
        ).catchError((error) {
          emit(UnlikePostError(error.toString()));
          print('errror' + error.toString());
        });
      });
    });
  }
  void deletePostImage() {
    postImageUrl = null;
    postImage = null;
    emit(
        DeletePostImageSuccess());
  }
  //get all users
  List<SocialMediaUser> users = [];
  void getAllUsers() {
    emit(GetAllUsersLoading());
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((data) {      users = data.docs.map((doc) {
        return SocialMediaUser.fromJson(doc.data());
      }).toList();
      emit(GetAllUsersSuccess());
    }).onError((error) {
      emit(GetAllUsersError(error.toString()));
    });
  }

  //send message from user to user
  void sendMessage({required String message,required String receiverId}) {
    print( 'RECEIVER IDDD'+receiverId);

    emit(SendMessageLoading());
    var messageId=Uuid().v4();
    Message messageModel = Message(
      dateTime: Timestamp.now(),
      time:FieldValue.serverTimestamp().toString(),
      receiverId: receiverId,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      message: message,
      messageId: messageId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('messages')
        .doc(receiverId)
        .collection('messages')
        .doc(messageId)
        .set(
          messageModel.toMap(),
        );
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('messages')
        .doc(uId)
        .collection('messages')
        .doc(messageId)
        .set(
          messageModel.toMap(),
        );
    emit(SendMessageSuccess());
  }
  //get all messages
  List<Message> messages = [];
  void getAllMessages({required String receiverId}) {
    emit(GetAllMessagesLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(socialMediaUser!.uid!)
        .collection('messages')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime', descending: false)
        .snapshots()
        .listen((data) {
          print('# receiver id');
          print(receiverId);
          print('# messsssagees');
          print('data'+data.docs.length.toString());

      messages = data.docs.map((doc) {
        return Message.fromJson(doc.data());
      }).toList();
      print('text messages :::');
      //print('messages'+messages[0].message??'nothing');
      emit(GetAllMessagesSuccess());
    }).onError((error) {
      emit(GetAllMessagesError(error.toString()));
    });
  }
//subscribe to topic
  void subscribeToTopic({required String topic}) {
    emit(SubscribeToTopicLoading());
    FirebaseMessaging.instance.subscribeToTopic(topic);
    emit(SubscribeToTopicSuccess());
  }
  //unsubscribe to topic
  void unsubscribeToTopic({required String topic}) {
    emit(UnsubscribeToTopicLoading());
    FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    emit(UnsubscribeToTopicSuccess());
  }
  //post fcm token to firebase firestore  using dio helper
  void sendFcmNotification(
      {
     String? message
    , String? token
      }
      ) {
    emit(PostFcmTokenLoading());
    //Dio dio = Dio();
    DioHelper.postData(
      data: {
        'to': '${token}',
        'notification': {
          'body':  '${message}',
          'title': '${FirebaseAuth.instance.currentUser!.email}+sent you a new message',
          'sound': 'default',
          'click_action': 'FCM_PLUGIN_ACTIVITY',
        },
        'data': {
          'click_action': 'FCM_PLUGIN_ACTIVITY',
        },
      },
    );
    emit(PostFcmTokenSuccess());
  }
    //sent nofiacation to user
    Future<void> sendNotification({
      required String receiverId,
      required String message
      // ,String? contentId
      //,String? contentKey

    }) async {
      emit(SendNotificationLoading());
      var notificationId=Uuid().v4();
      NotificationModel notificationModel = NotificationModel(
        notificationId: notificationId,
        receiverId: receiverId,
        senderId: FirebaseAuth.instance.currentUser!.uid,
      //  contentKey: contentKey,
       // contentId: contentId,
        senderName: socialMediaUser?.name??'unKnown',
        content: message,
        serverTimeStamp: FieldValue.serverTimestamp(),
        read: false,
        dateTime: Timestamp.now(),
        senderProfilePicture: FirebaseAuth.instance.currentUser!.photoURL,
      );
      //  notificationId: notificationId,
        // receiverId: receiverId,
      // senderId: FirebaseAuth.instance.currentUser!.uid,
      //  message: message,
      //  time:FieldValue.serverTimestamp(),
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('notifications')
          .doc(notificationId)
          .set(
            notificationModel.toMap(),
          );
      emit(SendNotificationSuccess());
    }
    //get all notifications
    List<NotificationModel> notifications = [];
    void getAllNotifications(
       //{
       //  required String receiverId
       // }
       ) {
      emit(GetAllNotificationsLoading());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('notifications').
      orderBy('dateTime',descending: true)
          .snapshots()
          .listen((data) {
            print('dh #DDDDDDD il NOTIFICATIN'
                '\n'
                '\n'
                '\n'
                '\n'
                '\n'
                '\n'
                );
            print( notifications.length);

        notifications = data.docs.map((doc) {
          return NotificationModel.fromJson(doc.data());
        }).toList();
        emit(GetAllNotificationsSuccess());
      }).onError((error) {
        emit(GetAllNotificationsError(error.toString()));
      });
    }
    //number of unread notifications
    int unreadNotificationsCount = 0;
    void getUnreadNotificationsCount({
      required String receiverId
    }) {
      emit(GetUnreadNotificationsCountLoading());
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('notifications')
          .where('read', isEqualTo: false)
          .snapshots()
          .listen((data) {
        unreadNotificationsCount = data.docs.length;
        emit(GetUnreadNotificationsCountSuccess());
      }).onError((error) {
        emit(GetUnreadNotificationsCountError(error.toString()));
      });
    }


    //delete notification
    void deleteNotification({required String notificationId}) {
      emit(DeleteNotificationLoading());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('notifications')
          .doc(notificationId)
          .delete()
          .then((value) => {
        emit(DeleteNotificationSuccess()),
      }).catchError((error) {
        emit(DeleteNotificationError(error.toString()));
      });
    }

 Future<void> sendFriendRequest({
   required String receiverId
 }) async {
      emit(SendFriendRequestLoading());
      var friendRequestId = Uuid().v4();
      FriendRequestModel friendRequestModel = FriendRequestModel(
        senderName: socialMediaUser?.name,
        senderEmail: FirebaseAuth.instance.currentUser!.email,
        senderPhotoUrl: socialMediaUser?.profileImage??firstProfileImage,
        friendRequestId: friendRequestId,
        senderId: socialMediaUser?.uid!,
        receiverId: receiverId,
     //   serverTimeStamp: FieldValue.serverTimestamp(),
        dateTime: Timestamp.now(),
        status: 'pending',
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('friendRequests')
          .doc(socialMediaUser?.uid!)
          .set(
            friendRequestModel.toMap(),
          );
      emit(SendFriendRequestSuccess());
    }
    //get all friend requests
    List<FriendRequestModel> friendRequests = [];
    void getAllFriendRequests() {
      emit(GetAllFriendRequestsLoading());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('friendRequests')
          .snapshots()
          .listen((data) {
        friendRequests = data.docs.map((doc) {
          return FriendRequestModel.fromJson(doc.data());
        }).toList();
        emit(GetAllFriendRequestsSuccess());
         print('dh # friend request \n\n\n\n\n\n\n\n\n\n\n');
         print(friendRequests.length);
      }).onError((error) {
        emit(GetAllFriendRequestsError(error.toString()));
      });
    }
    //accept friend request
    Future<void> acceptFriendRequest({required String senderId}) async {
      emit(AcceptFriendRequestLoading());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('friendRequests')
          .doc(senderId)
          .update({
        'status': 'accepted',
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .collection('friendRequests')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'status': 'accepted',
      });
     // geMyPosts(senderId);

      emit(AcceptFriendRequestSuccess());
    }
    //get number of friend requests where status is pending
    int pendingFriendRequestsCount = 0;
    void getPendingFriendRequestsCount() {
      emit(GetPendingFriendRequestsCountLoading());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('friendRequests')
          .where('status', isEqualTo: 'pending')
          .snapshots()
          .listen((data) {
        pendingFriendRequestsCount = data.docs.length;
        emit(GetPendingFriendRequestsCountSuccess());
      }).onError((error) {
        emit(GetPendingFriendRequestsCountError(error.toString()));
      });
    }
    //delete friend request
    void deleteFriendRequest({required String senderId}) {
      emit(DeleteFriendRequestLoading());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('friendRequests')
          .doc(senderId)
          .delete()
          .then((value) => {
        emit(DeleteFriendRequestSuccess()),
      }).catchError((error) {
        emit(DeleteFriendRequestError(error.toString()));
      });
    }

  void resetPassword({
    required String email,
  })
  {
    emit(ResetPasswordLoading());
    FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    ).then((value) {
      emit(ResetPasswordSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(ResetPasswordError(
        error.toString(),
      ));
    });
  }
//search for user by using his name
  List<SocialMediaUser> searchedUser = [];
  void searchForUser({
    required String searchKey,
  }) {
    emit(SearchForUserLoading());
    FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: searchKey)
        .where('name', isLessThan: searchKey + 'z')
        .snapshots()
        .listen((data) {
      searchedUser = data.docs.map((doc) {
        return SocialMediaUser.fromJson(doc.data());
      }).toList();
      print('# search result \n\n\n\n\n\n\n\n\n\n');
      print(searchedUser.length);
      print(searchedUser[0].name);
      emit(SearchForUserSuccess(
         users,
      ));
    }).onError((error) {
      emit(SearchForUserError(error.toString()));
    });
  }
  List<Post> myPosts = [];
  Future<void> geMyPosts(String senderId) async {
    //clear posts list
 //   myPosts = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('posts')
        .snapshots()
        .listen((data) {
      myPosts = data.docs.map((doc) {
        return Post.fromJson(doc.data());
      }).toList();
      print('dh # my posts \n\n\n\n\n\n\n\n\n\n\n');
      print(myPosts.length);
      print(myPosts[0].name);

    }).onError((error) {
      print(error.toString());
    });
  }

 Future updateProfileImage({String? image}) async {
    emit(UpdateProfileImageLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({
      'profileImage': image,
    }).then((value) {
      //get profile image
      emit(UpdateProfileImageSuccess());
     // getProfileImage();
    }).catchError((error) {
      emit(UpdateProfileImageError(error.toString()));
    });
  }
   updateCoverImage({String? image}) {
    emit(UpdateCoverImageLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({
      'coverImage': image,
    }).then((value) {
      getCoverImageImage();
      emit(UpdateCoverImageSuccess());
    }).catchError((error) {
      emit(UpdateCoverImageError(error.toString()));
      print(error.toString());
    });
  }

  getProfileImageFromCache() {
    emit(GetProfileAndCoverLoading());
    CashHelper.getString2(key: 'profileImage').then((value) {
      profileImageUrl = value??firstProfileImage;
      emit(GetProfileAndCoverSuccess());
    }).catchError((error) {
      emit(GetValueProfileAndCoverError(error.toString()));
    });
    CashHelper.getString2(key: 'coverImage').then((value) {
      coverImageUrl = value??firstCoverImage;
      emit(GetValueProfileAndCoverSuccess());
    }).catchError((error) {
      emit(GetValueProfileAndCoverCacheError());
    });
  }
  getCoverImageImage() {
    emit(GetCoverImageLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      socialMediaUser?.coverImage = coverImageUrl;
      CashHelper.setString(key: 'coverImage', value: coverImageUrl!);
      emit(GetCoverImageSuccess());
    }).catchError((error) {
      emit(GetCoverImageError(error.toString()));
    });
    
  }
  //upload friend post list to colection post in firebase

}


