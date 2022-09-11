import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/data/models/SocialMediaUser.dart';
import 'package:friends/presentation/screens/widgets/buildMyPosts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../business_logic/news_cubit/auth_cubit.dart';
import '../../../shared/constants/my_colors.dart';
import '../../../shared/constants/strings.dart';

class FriendProfileScreen extends StatelessWidget {
  final SocialMediaUser userModel;

  const FriendProfileScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    //background image using asset image
                    //circle avatar of profile image
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .5,
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
                        image: NetworkImage(
                            '${userModel.coverImage ?? firstCoverImage}'),
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
                              '${userModel
                                  ?.profileImage ?? firstProfileImage}'),
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
                              '${userModel.name ?? 'reeefy'}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${userModel.bio ?? 'bio'}',
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
                    //TODO;hat il card kolo w 70t0 hena w 70t il text henak il awel
                  ],
                ),
                //text contain posts with allign top left
                //if my posts != null
                if(AuthCubit.get(context).myPosts.isNotEmpty)
                  Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                  ),

                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Posts :',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                buildMyPosts(context, userModel),
              ],
            ),
          ),
        );
      },
    );
  }
}
