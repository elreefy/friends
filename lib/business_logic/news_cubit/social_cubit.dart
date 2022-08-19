import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/presentation/screens/screens/HomeScreen.dart';
import 'package:friends/presentation/screens/screens/profile_screen.dart';
import 'package:friends/presentation/screens/screens/settings_screens.dart';
import 'package:meta/meta.dart';
import '../../presentation/screens/screens/friends.dart';
import '../../presentation/screens/screens/messanger_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../presentation/screens/screens/nofication.dart';
part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  var textEditingController= TextEditingController();
  var commentEditingController = TextEditingController();
   //currentIndex for navigation bar
  int currentIndex = 0;
  SocialCubit() : super(SocialInitial());


  static SocialCubit get(context) => BlocProvider.of(context);
 //upload profile image to firebase storage







  //List of widgets Screens for the upper navigation bar
  final List<Widget> upperNavigationBarScreens = [
    // HomeScreen(),
    // FriendsScreen(),
    // MessangerScreen(),
    // ProfileSccreen(),
    // NotificationScreen(),
    // SettingsScreen(),
  ];
//Change the current index of the upper navigation bar
  void changeCurrentIndex(int index) {
    currentIndex = index;
    print(currentIndex);
    emit(CurrentIndexChanged(currentIndex: currentIndex));
  }


  //Todo: get user data
  getUserData(
    String uId,
      ) {
    emit(GetUserDataLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          print('USER DATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
          print(value.data());
    }).catchError((error) {
      emit(GetUserDataError(error));
    });
  }
  void sendVerificationCode() {
    emit(SendVerificationCodeLoading());
      FirebaseAuth.instance.currentUser!.sendEmailVerification()
        .then((value) {
      emit(SendVerificationCodeSuccess());
    }).catchError((error) {
      emit(SendVerificationCodeError(error.toString()));
    });
  }

}

