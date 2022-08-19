import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/shared/components/components.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../business_logic/news_cubit/auth_cubit.dart';
import '../../../shared/constants/my_colors.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({Key? key}) : super(key: key);
 //var  ImagePicker picker = ImagePicker();
  // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    File? image;
 //  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
   final ImagePicker _picker = ImagePicker();
   // Pick an image
   // Capture a photo
   getImage() async {
     final pickedFile = await _picker.getImage(source: ImageSource.gallery);
     if (pickedFile != null) {
       image = File(pickedFile.path);
       print(image);
     }else{
       print('no image');
     }
   }



  @override
  Widget build(BuildContext context)
  {

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AuthCubit.get(context).nameEditingController.text = AuthCubit.get(context).socialMediaUser!.email!;
      //  AuthCubit.get(context).passwordEditingController.text = AuthCubit.get(context).socialMediaUser!.phone!;
       AuthCubit.get(context).bioEditingController.text = AuthCubit.get(context).socialMediaUser!.bio!;

        return Scaffold(
          appBar: //appar contain retyrn back arrow and text edit profile screen and icon save
          AppBar(
            title: Text('Edit Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.save,
                  color: Colors.blue,
                ),
                onPressed: () {
                  AuthCubit.get(context).updateUser(
                      bio: AuthCubit.get(context).bioEditingController.text,
                      user: AuthCubit.get(context).nameEditingController.text,
                      password: AuthCubit.get(context).passwordEditingController.text,
                  );
                }
                ,
              ),
            ],
          ),
          body: Stack(
            children: [
              //background image using asset image

              //circle avatar of profile image
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .9,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: Colors.white,
              ),
              if(AuthCubit.get(context).coverImage==null)
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Image(
                  image: AssetImage('lib/background.jpeg'),
                  width: double.infinity,
                  height: //height of the screen
                  MediaQuery
                      .of(context)
                      .size
                      .height * .2,

                  fit: BoxFit.cover,
                ),
              ),
              if(AuthCubit.get(context).coverImage!=null)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Image(
                    image:FileImage(AuthCubit.get(context).coverImage!),
                    width: double.infinity,
                    height: //height of the screen
                    MediaQuery
                        .of(context)
                        .size
                        .height * .2,

                    fit: BoxFit.cover,
                  ),
                ),
              if(AuthCubit.get(context).profileImage==null)
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
                        '${AuthCubit
                            .get(context)
                            .socialMediaUser!
                            .profileImage}'),
                    // backgroundImage: AssetImage(
                    //     'lib/background.jpeg'
                    // ),
                  ),
                ),
              ),

              if(AuthCubit.get(context).profileImage!=null)
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
                      backgroundImage: FileImage(AuthCubit.get(context).profileImage!),
                      // backgroundImage: AssetImage(
                      //     'lib/background.jpeg'
                      // ),
                    ),
                  ),
                ),



              //column contain 3 default textformfield one for name and one for password and one for bio
              Positioned(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * .35,
                left: MediaQuery
                    .of(context)
                    .size
                    .width * .1,
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .8,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .35,
                  child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //user name

                    defaultFormField(
                      controller: AuthCubit.get(context).nameEditingController,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.person,
                  //      hint: AuthCubit.get(context).socialMediaUser!.email!,

                    ),
                   //phone number
                    defaultFormField(controller: AuthCubit.get(context).passwordEditingController,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.lock,
                       hint:  AuthCubit.get(context).passwordEditingController.text??'01097051812',
                    ),
                   // bio
                    defaultFormField(
                      controller: AuthCubit.get(context).bioEditingController,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.person,
                        hint: AuthCubit.get(context).bioEditingController.text??'write bioo',
                    ),
                  ],
                ),
                ),
              ),
              //cirrcle avatar of camera icon and grey color of the circle
              Positioned(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * .22,
                left: MediaQuery
                    .of(context)
                    .size
                    .width * .57,
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .12,
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * .12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      AuthCubit.get(context).getImageFromGallery().then((value) => {
                        AuthCubit.get(context).uploadProfileImage(
                            image:
                        AuthCubit.get(context).profileImage!
                        ),
                      // AuthCubit.get(context).createNewPost(
                      // post: 'zamalek ya 3i',
                      // postImage:AuthCubit.get(context).profileImage!
                      // ),
                      });
                      // AuthCubit.get(context).create new post

                    },
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * .16,
                left: MediaQuery
                    .of(context)
                    .size
                    .width * .8,
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .12,
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * .12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      //get image from gallery
                     AuthCubit.get(context).getCoverImage().then((value) => {
                       AuthCubit.get(context).uploadCoverImage(
                           image:
                           AuthCubit.get(context).coverImage!
                       ),
                     });
                    },
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );

  }


}
