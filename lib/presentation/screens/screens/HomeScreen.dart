import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:friends/presentation/screens/screens/profile_screen.dart';
import 'package:friends/presentation/screens/screens/settings_screens.dart';
import 'package:friends/presentation/screens/widgets/buildHomeScreen.dart';
import 'package:friends/shared/constants/icon_broken.dart';
import 'package:friends/shared/constants/my_colors.dart';
import 'package:iconsax/iconsax.dart';
import '../../../business_logic/news_cubit/social_cubit.dart';
import 'package:iconsax/iconsax.dart';

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
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var socialCubit=SocialCubit.get(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: MyColors.primaryColor,
            appBar: //text 'friends' in the app bar and the icon is a search icon at the right without the the row back
            AppBar(
              //remove the return back icon
              automaticallyImplyLeading: false,
              title: Padding(
                padding: EdgeInsets.only(
                  top: height * 0.03,
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
            //  Navigator.pushNamed(context, '/search');
                    },
          ),
                ),
              ],
            ),
            body:
            Column(
              children: [
                //Todo: add veriffffy
            //    if(FirebaseAuth.instance.currentUser?.emailVerified==false&&socialCubit.currentIndex==0)
            //       Container(
            //       color: Colors.amberAccent[200],
            //       height: .1*height,
            //       width: width,
            //       child: //row contain text verify your email and button verify
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Padding(
            //             padding: const EdgeInsets.only(left: 15.0),
            //             child: Text('plz Verify your email',
            //               style: TextStyle(
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ),
            //           FlatButton(
            //             onPressed: () {
            //              //send verification code to the user
            //               socialCubit.sendVerificationCode();
            //               //reload the firebase user
            //               FirebaseAuth.instance.currentUser!.reload();
            //               //reload the screen
            //               Navigator.of(context).pushReplacementNamed('/home');
            //             },
            //             child: Text('Verify',
            //               style: TextStyle(
            //                 color: Colors.blue,
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),

                Card(

                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: .1*height,
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                            socialCubit.changeCurrentIndex(0);
                              },
                            child: Icon(
                                Iconsax.home,
                                color: socialCubit.currentIndex == 0
                                    ? Colors.blue
                                    : Colors.grey,
                            ),
                          ),
                          //icon of the home screen
                      //    IconButton(
                       //     icon: Icon(IconSax.home),
                         //   onPressed: () {
                          //    Navigator.of(context).pushReplacementNamed('/home');
                        //    },
                        //  ),
                          //icon of the friends screen
                          InkWell(onTap: () {
                            socialCubit.changeCurrentIndex(1);
                          },
                            child: Icon(
                                Iconsax.people,
                                color: socialCubit.currentIndex == 1
                                    ? Colors.blue
                                    : Colors.grey,
                            ),
                          ),
                         // icon of the massage screen
                          InkWell(
                            onTap: () {
                              socialCubit.changeCurrentIndex(2);
                            },
                            child: Icon(
                                Iconsax.message,
                                color: socialCubit.currentIndex == 2
                                    ? Colors.blue
                                    : Colors.grey,
                            ),
                          ),

                          //icon of the profile screen
                          InkWell(
                            onTap: () {
                              socialCubit.changeCurrentIndex(3);
                            },
                            child: Icon(
                                Iconsax.personalcard,
                                color: socialCubit.currentIndex == 3
                                    ? Colors.blue
                                    : Colors.grey,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              socialCubit.changeCurrentIndex(4);
                            },
                            child: FaIcon(
                              FontAwesomeIcons.bell,
                              color: socialCubit.currentIndex == 4
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              socialCubit.changeCurrentIndex(5);
                            },
                              child: Icon(Iconsax.settings,
                                color: socialCubit.currentIndex == 5
                                    ? Colors.blue
                                    : Colors.grey,)
                          ),

                          //icon of the settings screen
                        ],
                      ),
                    ),
                  ),
                ),

               //if statement for the current index of the screen
                if(socialCubit.currentIndex==0)
                  buildHomeScreen(
                    context: context,
                    width: width,
                    socialCubit: socialCubit,
                  ),
                if(socialCubit.currentIndex==0)
                  buildPost(context),
                  //if the current index is 0 then go to the home screen
                if(socialCubit.currentIndex==1)
                  //if the current index is 1 then go to the friends screen
                  buildFriendsScreens( context),
                if(socialCubit.currentIndex==2)
                  //if the current index is 2 then go to the massage screen
                  buildMessangerScreen( context),
                if(socialCubit.currentIndex==3)
                  //if the current index is 3 then go to the profile screen
                  buildProfileScreen( context, socialCubit),
                if(socialCubit.currentIndex==4)
                  //if the current index is 4 then go to the notification screen
                  buildNoficationScreen( context      ),
                if(socialCubit.currentIndex==5)
                  //if the current index is 5 then go to the settings screen
                  buildSettings(  context),



          //      createFaceBookPost(context),

              ],
            ) ,

          ),
        );
      },
    );
  }
  createFaceBookPost(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: .1*height,
      width: width,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 8.0,
            child: Container(
              height: .33 *height,
              width: width,
              child: Column(
                children: [
                  //row contain the image and the text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        //image of the post
                        Container(
                          height: .1*height,
                          width: .1*width,
                          child: Image.asset('assets/images/profile.png'),
                        ),
                        //cloumn contain name of the user and date of the post
                        SizedBox(
                          width: .05*width,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Ahmed',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('1 hour ago',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: .02*height,
                  ),
                  //text of the post
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: .1*height,
                      width: width,
                      child: Text('This is a post',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //row contain number of likes  and number of comments with icons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Iconsax.heart,
                              color: Colors.red,
                            ),
                            Text('10',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //row contain the icons of the like, comment, share and more
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: <Widget>[
                        //row contain circle avatar for image and text form field with controller
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: //png image using imag.assets
                              AssetImage('assets/images/profile.png'),
                            ),
                            SizedBox(
                              width: .05*width,
                            ),
                            Container(
                              width: width*.49,
                              child: TextField(
                                controller: SocialCubit.get(context).commentEditingController,
                                decoration: InputDecoration(
                                  hintText: 'write a comment...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Iconsax.heart,
                          color: Colors.redAccent,
                        ),
                        //text for number of comments
                        Text('10',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: .02*width,
                        ),

                        Icon(Iconsax.share,
                          color: Colors.blue,
                        ),
                        //text for number of shares
                        Text('10',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
