import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  //create email controller and password controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


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
        //print(value.user.uid);
        print(value.user!.email);
        emit(FireBaseLoginSuccess());
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
  void signUp({required String user, required String password,  String? phoneNumber}) {
     emit(SignUpLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: user, password: password)
        .then((value) {
          print(value.user!.email);
          emit(SignUpSuccess());
        }).catchError((error) {
      emit(SignUpError(error.toString()));
      print(error.toString());
    });
  }

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
    emit(GoogleLoginSuccess());
  }
//logout of google
  void signOutGoogle() async{
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    emit(FireBaseLoginInitial());
  }

}
