import 'dart:io';

import 'package:bloc/bloc.dart';

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

  AuthCubit() : super(FireBaseLoginInitial());

  bool isPasswordVisible=true;
  static AuthCubit get(context) => BlocProvider.of(context);
  //take the user and password and check if they are correct using firebase
  //if they are correct then move to the next screen
  //if they are not correct then show error message
  void login({required String user, required String password}) {
    emit(FireBaseLoginLoading());
  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user, password: password)
      .then((value) {
        print(value.user!.uid);
        print(value.user!.email);
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
    String? phoneNumber
  }) {
     emit(SignUpLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email:    user,
        password: password
    )
        .then((value) {
      userCreate(
        profileImage: 'https://i.pinimg.com/736x/68/a5/aa/68a5aa104457ecac4d4136285a830e3e.jpg',
       isVerifcationSend: false,
        password: password,
        user: user,
        uid: value.user!.uid,
        phoneNumber: phoneNumber,
      );

          print(value.user!.email);
          emit(SignUpSuccess(
              value.user!.uid));
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
    required bool isVerifcationSend,
  }) {
    emit(UserCreateLoading());
    socialMediaUser = SocialMediaUser(
      coverImage: 'https://i.pinimg.com/736x/68/a5/aa/68a5aa104457ecac4d4136285a830e3e.jpg',
      profileImage: 'https://i.pinimg.com/736x/68/a5/aa/68a5aa104457ecac4d4136285a830e3e.jpg',
      bio: 'write biooo',
      email: user,
      uid: uid,
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
    // print(authResult.user!.uid);
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

    emit(FireBaseLoginInitial());
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
  String? profileImageUrl;
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
  String? coverImageUrl;
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
    required String password,
     bool? isVerifcationSend,
    String? phoneNumber
  }) {
    emit(UpdateUserLoading());
    socialMediaUser = SocialMediaUser(
      uid: FirebaseAuth.instance.currentUser!.uid,
      profileImage: profileImageUrl,
      bio: bio,
      email:user,
      coverImage: coverImageUrl,
      phone: password,

    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(socialMediaUser!.toJson()).then((value) {
          //get user data from firebase firestore
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) {
                emit(UpdateUserSuccess()  );
              }).catchError((error) {
            emit(UpdateUserError(error.toString()));
          });
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



  void createNewPost({required String post,required File postImage}) async {
   var postId=Uuid().v4();
    emit(CreateNewPostLoading());
    Post postModel = Post(
    uId: FirebaseAuth.instance.currentUser!.uid,
     postImage: postImageUrl,
      post: post,
     dateTime:FieldValue.serverTimestamp(),
      postId:postId,
    );
    Reference storageReference = FirebaseStorage.instance.ref().child(
        'posts/${
            Uri
            .parse(postImage.path)
            .pathSegments
            .last}'
    );
    UploadTask uploadTask = storageReference.putFile(postImage);
    emit(CreateNewPostSuccess());
    await uploadTask.then((value) {
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        print(' POST IMAGE URLLLL '+fileURL);
        postImageUrl = fileURL;
        FirebaseFirestore.instance.collection('posts').doc(postId).
        set(
           postModel.toMap(),
        );
        emit(CreateNewPostSuccess());
        print(' post image url '+postImageUrl!);
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
  void uploadText({required String post}) {
    var postId=Uuid().v4();
    emit(UploadTextLoading());
    Post postModel = Post(
      uId: FirebaseAuth.instance.currentUser!.uid,
      postImage: null,
      post: post,
      dateTime:FieldValue.serverTimestamp(),
      postId: postId,
    );
    FirebaseFirestore.instance.collection('posts').doc(postId).
    set(
       postModel.toMap(),
    );
    emit(UploadTextSuccess());
  }

  //upload image to firebase firestore
  //get all posts
  List<Post> posts = [];
  void getAllPosts() {
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
  int postLikesCount = 0;
  void getPostLikesCount({required String postId}) {
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
    // Post postModel = Post(
    //   uId: FirebaseAuth.instance.currentUser!.uid,
    //   postImage: null,
    //   post: null,
    //   dateTime:FieldValue.serverTimestamp(),
    // );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(FirebaseAuth.instance.currentUser!.uid)
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
        .listen((data) {
      users = data.docs.map((doc) {
        return SocialMediaUser.fromJson(doc.data());
      }).toList();
      emit(GetAllUsersSuccess());
    }).onError((error) {
      emit(GetAllUsersError(error.toString()));
    });
  }


}
