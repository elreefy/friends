import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/shared/constants/strings.dart';
import 'package:iconsax/iconsax.dart';

import '../../../business_logic/news_cubit/auth_cubit.dart';
import '../../../shared/constants/my_colors.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            //change the back arrow to a cross
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Create Post',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.send,
                  color: Colors.black,
                ),
                onPressed: () {
                  if(AuthCubit.get(context).postImage != null) {
                    AuthCubit.get(context).createNewPost(
                      post: AuthCubit.get(context).postController.text,
                      postImage:AuthCubit.get(context).postImage!,
                      name:AuthCubit.get(context).socialMediaUser?.name??'reeefy',
                      senderId: uId!,
                    ).then((value) {
                      AuthCubit.get(context).postController.clear();
                      AuthCubit.get(context).postImage = null;
                      Navigator.pop(context);
                    });
                  } else {
                    AuthCubit.get(context).uploadText(
                      name://current user name
                      AuthCubit.get(context).socialMediaUser?.name??'reeefy',
                      post: AuthCubit.get(context).postController.text,
                      senderId: uId,
                    ).then((value) {
                      AuthCubit.get(context).postController.clear();
                      Navigator.pop(context);
                    });
                  }

                },
              ),
            ],
            elevation: 8,
            titleSpacing: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                //row contain circle avatar whic is the profile picture of the user and the name of the user
                //if state is CreateNewPostLoading show liner progress indicator
                if(state is CreateNewPostLoading
                    || state is UploadTextLoading)
                   Padding(
                     padding: const EdgeInsets.only(top: 25.0),
                     child: LinearProgressIndicator(color: Colors.blue,),
                   ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                                AuthCubit
                                .get(context)
                                .socialMediaUser!
                                .profileImage??firstProfileImage
                        ),
                        radius: 30,
                      ),
                      SizedBox(width: 10,),
                      Text(AuthCubit.get(context).socialMediaUser!.name??'reeefy',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                      //text form field with no border contain text what is on your mind

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: .65*MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: AuthCubit.get(context).postController,
                          //no border
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'What is on your mind?',
                            hintStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20,),
                        //widget network image contain the image of the post
                       // if the post image is null then the image is not displayed
                        AuthCubit.get(context).postImage == null||
                            state is DeletePostImageSuccess?
                              Container()
                            : Stack(
                              children: [
                                Container(
                                  height: .35*MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child:Image(
                                    image:FileImage(AuthCubit.get(context).postImage!),
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
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      AuthCubit.get(context).deletePostImage();
                                    },
                                  ),
                                ),
                              ],
                            ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: .1*MediaQuery.of(context).size.height,
                    child: Card(
                      elevation: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap:(){
                              AuthCubit.get(context).getImageFromGallery(
                                typeOfImage: 1,
                              ).then((value) => {

                              // AuthCubit.get(context).uploadProfileImage(
                              //     image:
                              //     AuthCubit.get(context).profileImage!
                              // ),
                              // AuthCubit.get(context).createNewPost(
                              //     post: 'zamalek ya 3i',
                              //     postImage:AuthCubit.get(context).profileImage!
                              // ),
                            });
                              //go to homeScreen

                            },
                            child: Row(
                              children: [
                                Icon(Iconsax.camera,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 5,),
                                //text image
                                Text('Image',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Iconsax.gallery,
                                color: MyColors.redAccent,
                              ),
                              SizedBox(width: 5,),
                              //text gallery
                              Text('Gallery',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Iconsax.document,
                                color: Colors.green,
                              ),
                                SizedBox(width: 5,),
                              //text document
                              Text('Document',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],

            ),
          ),
        );
      },
    );
  }
}
