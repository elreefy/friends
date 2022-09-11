import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/data/models/SocialMediaUser.dart';
import 'package:iconsax/iconsax.dart';
import '../../../business_logic/news_cubit/auth_cubit.dart';
import '../../../business_logic/news_cubit/social_cubit.dart';
import '../../../shared/components/components.dart';
import '../../../shared/constants/strings.dart';

 buildMyPosts(
  context,
  SocialMediaUser user,
) {
  return createMyFaceBookPost(context,user);
}

//build the post with the image and the text field
//      AuthCubit.get(context).geMyPosts(uId!) ;
createMyFaceBookPost(BuildContext context,SocialMediaUser user) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Builder(
builder: (context) {
       AuthCubit.get(context).geMyPosts(user.uid!) ;
  return  BlocConsumer<AuthCubit, AuthState>(
    listener: (context, state) {
      // TODO: implement listener
    },
     builder: (context, state) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: AuthCubit.get(context).myPosts.length,
        itemBuilder: (context, index) {
          bool isLiked = AuthCubit.get(context).myPosts[index].isLiked!;
          {
            return Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 8.0,
              child: Container(
                padding: EdgeInsets.all(8.0),
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
                            height: .1 * height,
                            width: .1 * width,
                            child: Image(
                              image: NetworkImage(AuthCubit.get(context)
                                  .myPosts[index]
                                  .profilePicture),
                              width: double.infinity,
                              height: //height of the screen
                              MediaQuery.of(context).size.height * .2,
                              fit: BoxFit.cover,
                            ),
                          ),
                          //cloumn contain name of the user and date of the post
                          SizedBox(
                            width: .05 * width,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                //current user name
                                AuthCubit.get(context).myPosts[index].name ??
                                    'reeefy',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                //post date time getNowDateTime(AuthCubit.get(context).myPosts[index].dateTime)
                                getNowDateTime(AuthCubit.get(context)
                                    .myPosts[index]
                                    .date!),
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
                      height: .02 * height,
                    ),
                    //text of the post
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: .1 * height,
                        width: width,
                        child: Text(
                          AuthCubit.get(context).myPosts![index].post!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: .02 * height,
                    ),
                    //psot image
                    if (AuthCubit.get(context).myPosts![index].postImage !=
                        null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          height: .3 * height,
                          width: width,
                          child: //use image network to get the image from the url of the post
                          Image.network(AuthCubit.get(context)
                              .myPosts![index]
                              .postImage!),
                        ),
                      ),
                    //row contain number of likes  and number of comments with icons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    // AuthCubit.get(context).getPostLikesCount(
                                    //     postId: AuthCubit.get(context).myPosts![index].postId!);
                                    // AuthCubit.get(context)
                                    //     .createPostLike(
                                    //     postId:'${AuthCubit.get(context).myPosts[index].postId}'
                                    // );
                                    if (AuthCubit.get(context)
                                        .myPosts[index]
                                        .isLiked ==
                                        false)
                                      AuthCubit.get(context).likePost(
                                          postId: AuthCubit.get(context)
                                              .myPosts![index]
                                              .postId!);
                                    if (AuthCubit.get(context)
                                        .myPosts[index]
                                        .isLiked ==
                                        true)
                                      AuthCubit.get(context).unlikePost(
                                          postId: AuthCubit.get(context)
                                              .myPosts![index]
                                              .postId!);
                                  },
                                  icon: isLiked == false
                                      ? Icon(
                                    Iconsax.heart,
                                    color: Colors.red,
                                  )
                                      : Icon(
                                    Iconsax.heart5,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  AuthCubit.get(context)
                                      .myPosts![index]
                                      .likes
                                      .toString(),
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
                    //row contain the icons of the like, comment, share and more
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: <Widget>[
                          //row contain circle avatar for image and text form field with controller
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: //network image
                                NetworkImage(AuthCubit.get(context)
                                    .myPosts[index]
                                    .profilePicture),
                              ),
                              SizedBox(
                                width: .03 * width,
                              ),
                              Container(
                                width: width * .4,
                                child: TextField(
                                  controller: AuthCubit.get(context)
                                      .commentEditingController,
                                  decoration: InputDecoration(
                                    hintText: 'write a comment...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: .04 * width,
                          ),
                          isLiked == false
                              ? Icon(
                            Iconsax.heart,
                            color: Colors.red,
                          )
                              : Icon(
                            Iconsax.heart5,
                            color: Colors.red,
                          ),
                          //text for number of comments
                          Text(
                            AuthCubit.get(context)
                                .myPosts![index]
                                .likes
                                .toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: .02 * width,
                          ),

                          Icon(
                            Iconsax.share,
                            color: Colors.blue,
                          ),
                          //text for number of shares
                          Text(
                            '0',
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
          }
        },
      );
    },
  );
   },
  );
}
