import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/shared/constants/strings.dart';
import 'package:iconsax/iconsax.dart';
import '../../../business_logic/news_cubit/auth_cubit.dart';
import '../../../business_logic/news_cubit/social_cubit.dart';
import '../../../shared/components/components.dart';
import '../../../shared/constants/my_colors.dart';
BlocConsumer buildProfileScreen(BuildContext context,socialCubit) {
  //return image of profile
  return BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var coverImage = AuthCubit.get(context).coverImage;
    return ConditionalBuilder(
      condition:
         AuthCubit.get(context).socialMediaUser != null,
        builder: (context )=>
          Container(
            //background image using asset image
            child: Stack(
              children: [
                //background image using asset image
                //circle avatar of profile image
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .75,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Image(
                    image:NetworkImage(
                           AuthCubit
                            .get(context).socialMediaUser!.coverImage??firstCoverImage),
                    width: double.infinity,
                    height: //height of the screen
                    MediaQuery
                        .of(context)
                        .size
                        .height * .2,

                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * .1,
                  left: MediaQuery
                      .of(context)
                      .size
                      .width * .325,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .35,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * .35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: CircleAvatar( //use image from network
                      backgroundImage: NetworkImage(
                          AuthCubit
                              .get(context).
                          socialMediaUser!.profileImage??firstProfileImage),
                      // backgroundImage: AssetImage(
                      //     'lib/background.jpeg'
                      // ),
                    ),
                  ),
                ),
                //Column containing name and bio
                Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * .25,
                  left: MediaQuery
                      .of(context)
                      .size
                      .width * .05,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .9,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${AuthCubit
                              .get(context)
                              .socialMediaUser
                              ?.name??'reeefy'}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${AuthCubit
                              .get(context)
                              .socialMediaUser
                              ?.bio??'write bio'}',
                          style: TextStyle(
                            //sub title of the profile
                            fontSize: 15,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Row containing number of posts, followers, following
                Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * .35,
                  left: MediaQuery
                      .of(context)
                      .size
                      .width * .05,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .9,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'posts',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '10',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'followers',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '10',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'following',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '10',
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
                ),
                //edit profile button
                Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * .5,
                  left: MediaQuery
                      .of(context)
                      .size
                      .width * .05,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .9,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .05,
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.pushNamed(context, '/editProfile');
                      },
                      child: Text(
                        'edit profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                //TODO;hat il card kolo w 70t0 hena w 70t il text henak il awel
                Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * .55,
                  left: MediaQuery
                      .of(context)
                      .size
                      .width * .05,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 26,
                          backgroundImage: //png image using imag.assets
                          AssetImage('assets/images/profile.png'),
                          //
                        ),
                        Container(
                          width: //width of the screen
                          MediaQuery
                              .of(context)
                              .size
                              .width * .7,
                          child: TextField(
                            controller: socialCubit.textEditingController,
                            decoration: InputDecoration(
                              hintText: 'What is on your mind?',
                              //remove the border of the text field
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * .65,
                  left: MediaQuery
                      .of(context)
                      .size
                      .width * .05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(Iconsax.camera,
                        color: Colors.blue,
                      ),
                      //text image
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'image',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .15,
                      ),
                      Icon(Iconsax.gallery,
                        color: MyColors.redAccent,
                      ),
                      //text gallery
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'gallery',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width*.2,
                      // ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .15,
                      ),
                      Icon(Iconsax.document,
                        color: Colors.green,
                      ),
                      //text docs
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'docs',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        fallback: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  );
}