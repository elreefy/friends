import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:friends/business_logic/news_cubit/auth_cubit.dart';
import 'package:friends/presentation/screens/screens/profile_screen.dart';
import 'package:friends/presentation/screens/screens/settings_screens.dart';
import 'package:friends/presentation/screens/widgets/buildHomeScreen.dart';
import 'package:friends/shared/constants/my_colors.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/cashe_helper.dart';
import '../../../shared/components/components.dart';
import '../../../shared/constants/strings.dart';
import 'friends.dart';
import 'messanger_screen.dart';
import 'nofication.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //height of the screen
    final height = MediaQuery.of(context).size.height;
    //width of the screen
    final width = MediaQuery.of(context).size.width;
    return Builder(
      builder: (context) {

        //get profile image from the cashe helper and save value in profileImage variable
           AuthCubit.get(context).profileImageUrl = CashHelper.getData(key: 'profileImage')??firstProfileImage;
        //get cover image from the cashe helper and save value in cover variable
            AuthCubit.get(context).coverImageUrl = CashHelper.getData(key: 'coverImage')??firstCoverImage;
        if(AuthCubit.get(context).socialMediaUser == null) {
          AuthCubit.get(context).getUserInfo(uId!).then((value) async {
         await AuthCubit.get(context).setAllPostsIsLiked().then((value) {
              AuthCubit.get(context).getAllPosts();
            });
          });
        }else {
          AuthCubit.get(context).setAllPostsIsLiked().then((value) {
        AuthCubit.get(context).getAllPosts();
        });

        }


        return  BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            //if state is email verified show toast2
             if (FirebaseAuth.instance.currentUser?.emailVerified==true) {
              // showToast2(
              //     msg: 'Email Verified Successfully',
              // state: ToastStates.SUCCESS,
              //   fontSize: 7
              //     );
                }
          },
          builder: (context, state) {
            var authCubit=AuthCubit.get(context);
            var socialMediaUser=AuthCubit.get(context).socialMediaUser;
            return socialMediaUser!=null? SafeArea(
              child: Scaffold(
                backgroundColor: MyColors.primaryColor,
                appBar: //text 'friends' in the app bar and the icon is a search icon at the right without the the row back
                AppBar(
                  //remove the return back icon
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.015,
                    ),
                    child: Image(
                      image: AssetImage(
                          'lib/Light Logo.png'),
                      width: width * 0.6,
                      height: height * 0.09,
                      fit: BoxFit.cover,
                    ),
                  ),
                  elevation: 0,
                  titleSpacing: 0,
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.03,
                      ),
                      child: IconButton(
                        icon:  Icon(Icons.search),
                        onPressed: () {
                          //navigate to search screen

                          Navigator.pushNamed(context, '/search');
                          //  Navigator.pushNamed(context, '/userProfile',arguments: socialMediaUser);
                        },
                      ),
                    ),
                  ],

                ),
                body:
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(

                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: .1*height,
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    authCubit.changeCurrentIndex(0);
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Icon(
                                      Iconsax.home,
                                      color: authCubit.currentIndex == 0
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                //icon of the friends screen
                                InkWell(onTap: () {
                                  authCubit.changeCurrentIndex(1);
                                },
                                  child: //icon of the friends screen with badge of the number of pendingFriendRequestsCount
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: 9,
                                          left: 5,
                                          child: Icon(
                                            Iconsax.people,
                                            color: authCubit.currentIndex == 1
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                        if (AuthCubit.get(context).pendingFriendRequestsCount > 0)
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${AuthCubit.get(context).pendingFriendRequestsCount}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                // icon of the massage screen
                                InkWell(
                                  onTap: () {
                                    authCubit.changeCurrentIndex(2);
                                  },
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Icon(
                                      Iconsax.message,
                                      color: authCubit.currentIndex == 2
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ),
                                ),

                                //icon of the profile screen
                                InkWell(
                                  onTap: () {
                                    authCubit.changeCurrentIndex(3);
                                  },
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Icon(
                                      Iconsax.personalcard,
                                      color: authCubit.currentIndex == 3
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    authCubit.changeCurrentIndex(4);
                                  },
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        left: 8.0,
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.bell,
                                        color: authCubit.currentIndex == 4
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      authCubit.changeCurrentIndex(5);
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 100.0,
                                        ),
                                        child: Icon(Iconsax.settings,
                                          color: authCubit.currentIndex == 5
                                              ? Colors.blue
                                              : Colors.grey,),
                                      ),
                                    )
                                ),

                                //icon of the settings screen
                              ],
                            ),
                          ),
                        ),
                      ),

                      //if statement for the current index of the screen
                      if(authCubit.currentIndex==0)
                        buildHomeScreen(
                          context: context,
                          width: width,
                          authCubit: authCubit,
                        ),
                      if(authCubit.currentIndex==0)
                        buildPost(context),
                      //if the current index is 0 then go to the home screen
                      if(authCubit.currentIndex==1)
                      //if the current index is 1 then go to the friends screen
                        buildFriendText(text: 'Friends Request'),
                      if(authCubit.currentIndex==1)
                        buildFriendsRequestList(context),

                      if(authCubit.currentIndex==2)
                      //if the current index is 2 then go to the massage screen
                        buildMessangerScreen( context),
                      if(authCubit.currentIndex==3)
                      //   //if the current index is 3 then go to the profile screen
                        buildProfileScreen( context, authCubit),
                      //   if(authCubit.currentIndex==3)
                      //      buildMyPosts(context),
                      if(authCubit.currentIndex==4)
                      //if the current index is 4 then go to the notification screen
                        buildNoficationScreen( context ),
                      if(authCubit.currentIndex==5)
                      //if the current index is 5 then go to the settings screen
                        buildSettings(  context),



                      //      createFaceBookPost(context),

                    ],
                  ),
                ) ,

              ),
            ):Container();
          },
        );
      },
    );
  }
}
