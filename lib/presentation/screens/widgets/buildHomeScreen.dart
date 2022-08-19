import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/business_logic/news_cubit/auth_cubit.dart';
import 'package:friends/business_logic/news_cubit/auth_cubit.dart';
import 'package:friends/business_logic/news_cubit/social_cubit.dart';
import 'package:iconsax/iconsax.dart';

import '../../../shared/constants/my_colors.dart';

buildHomeScreen({
  required BuildContext context,
  width,
  required SocialCubit socialCubit,
}
    ) {
  return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: //png image using imag.assets
                    AssetImage('assets/images/profile.png'),
                  ),
                  Container(
                    width: width*.7,
                    child: TextField(
                      controller: socialCubit.textEditingController,
                      decoration: InputDecoration(
                        hintText: 'What is on your mind?',
                        //remove the border of the text field
                        border: InputBorder.none,
                      ),
                      onTap: () {
                        //navigete to create new post screen using pushNamed
                        Navigator.pushNamed(context, '/createPost');
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(Iconsax.camera,
                    color: Colors.blue,
                  ),
                  Icon(Iconsax.gallery,
                    color: MyColors.redAccent,
                  ),
                  Icon(Iconsax.document,
                    color: Colors.green,
                  ),

                ],
              ),
            ),
          ],
        ),
      );
      //list view sepereated contain the posts
      // Expanded(
      //     child:createFaceBookPost(context)
      // ),

}
buildPost(context, ) {
  return Expanded(
           child:createFaceBookPost(context)
       );
}
//build the post with the image and the text field 
createFaceBookPost(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Container(
    height: .1*height,
    width: width,
    child: ListView.builder(
      itemCount: AuthCubit.get(context).posts?.length,
      itemBuilder: (context, index) {
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
                    child: Text(AuthCubit.get(context).posts![index].post!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: .02*height,
                ),
                //psot image
              if(AuthCubit.get(context).posts![index].postImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: .3*height,
                    width: width,
                    child: //use image network to get the image from the url of the post
                    Image.network(AuthCubit.get(context).posts![index].postImage!),
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
                                AuthCubit.get(context)
                                    .createPostLike(
                                    postId:'${AuthCubit.get(context).posts[index].postId}');
                              },
                              icon: Icon(Iconsax.heart,
                                color: Colors.red,
                              ),
                            ),
                            Text(AuthCubit.get(context).postLikesCount.toString(),
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
                            backgroundImage: //png image using imag.assets
                            AssetImage('assets/images/profile.png'),
                          ),
                          SizedBox(
                            width: .03*width,
                          ),
                          Container(
                            width: width*.4,
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
                      SizedBox(
                        width: .04*width,
                      ),
                      Icon(Iconsax.heart,
                        color: Colors.redAccent,
                      ),
                      //text for number of comments
                      Text(AuthCubit.get(context).postLikesCount.toString(),
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
                      Text('0',
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
  },
);
}
