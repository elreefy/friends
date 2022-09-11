import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/shared/components/components.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../../../business_logic/news_cubit/auth_cubit.dart';
import '../../../data/cashe_helper.dart';
import '../../../shared/constants/my_colors.dart';
import '../../../shared/constants/strings.dart';
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
    // AuthCubit.get(context).nameEditingController.text = AuthCubit.get(context).socialMediaUser!.name!;
     //AuthCubit.get(context).passwordEditingController.text = AuthCubit.get(context).socialMediaUser!.phone!;
     // AuthCubit.get(context).bioEditingController.text = AuthCubit.get(context).socialMediaUser!.bio!;

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
                       phone: AuthCubit.get(context).passwordEditingController.text,
                  );
                  //show toast
                  showToast2(
                    msg: 'Profile Updated Successfully',
                    state: ToastStates.SUCCESS,
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Image(
                  image: //network image
                  NetworkImage(
                           AuthCubit
                          .get(context)
                          .socialMediaUser!.coverImage??firstCoverImage
                  ),
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
                                .get(context)
                        .socialMediaUser!.profileImage??firstProfileImage
                    ),
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
                Form(
                  key: AuthCubit.get(context).formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //user name
                      defaultFormField2(
                        controller: AuthCubit.get(context).nameEditingController,
                        //cursor color grey
                        cursorColor: Colors.grey,
                        keyboardType: TextInputType.text,
                        validate: (String ) {
                          if (String!.isEmpty) {
                            return 'name must not be empty';
                          }
                        },
                        context: context,
                        prefix: Iconsax.user,
                        labelText: 'User Name',
                        hintText: AuthCubit.get(context).socialMediaUser!.name,

                      ),
                     //phone number
                     //  defaultFormField(
                     //    controller: AuthCubit.get(context).passwordEditingController,
                     //      keyboardType: TextInputType.text,
                     //      prefixIcon: Icons.lock,
                     //   //  hint:  AuthCubit.get(context).socialMediaUser!.phone??'01097051812',
                     //  ),
                     // bio
                      defaultFormField2(
                        controller: AuthCubit.get(context).bioEditingController,
                        keyboardType: TextInputType.text,
                        context: context,
                        validate: (String ) {
                          if (String!.isEmpty) {
                            return 'bio must not be empty';
                          }
                        },
                        prefix: Iconsax.info_circle,
                        labelText: 'Bio',
                        hintText:AuthCubit.get(context).socialMediaUser!.bio,
                      ),
                    ],
                  ),
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
                        ).then((value) => {
                          AuthCubit.get(context).updateProfileImage(
                            image: AuthCubit.get(context).profileImageUrl,
                          ).whenComplete(() => {
                          //AuthCubit.get(context).getProfileImage()
                          }),
                          //get user info
                        //  AuthCubit.get(context).getUserInfo(uId!),

                          //save the image in the cashe helper
                          CashHelper.saveData(
                            key: 'profileImage',
                            value: AuthCubit.get(context).profileImageUrl,
                          ),
                        }),

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
                       ).then((value) {
                          AuthCubit.get(context).updateCoverImage(
                            image: AuthCubit.get(context).coverImageUrl,
                          ).then((value) => {
                            //get user info
                            AuthCubit.get(context).getCoverImageImage(),
                            //save the image in the cashe helper
                            CashHelper.saveData(
                              key: 'coverImage',
                              value: AuthCubit.get(context).coverImageUrl,
                            ),
                          });
                        }),
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
