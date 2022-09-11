import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:friends/business_logic/news_cubit/auth_cubit.dart';

buildSettings(BuildContext context) {
  return BlocConsumer<AuthCubit, AuthState>(
    listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //text Notification
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          //container clolor grey which contain row of circle avatar and text
          Container(
            height: 0.08 * MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[200],
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      AuthCubit.get(context).socialMediaUser!.profileImage ??
                          'https://www.gstatic.com/webp/gallery/1.jpg'),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  AuthCubit.get(context).socialMediaUser!.name ?? 'reeefy',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                //icon button to log out
                IconButton(
                  onPressed: () {
                    AuthCubit.get(context).signOut();
                    //navigate to login screen
                    Navigator.pushReplacementNamed(
                        context, '/loginScreen'
                    );
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Account',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 0.08 * MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[200],
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(

                  child: Icon(
                    Icons.person,
                    color: Colors.grey[600],
                    size: 27,
                  ),
                  backgroundColor: Colors.grey[400],
                ),
                SizedBox(
                  width: 20,
                ),
                Text('Your Personal Info ',
                  //AuthCubit.get(context).socialMediaUser!.name ?? 'reeefy',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                //icon button to log out
                IconButton(
                  onPressed: () {

                //    navigate to login screen
                      Navigator.pushNamed(
                           context, '/editProfile'
                  );
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Container(
            height: 0.08 * MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[200],
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  child: Icon(
                    Icons.lock,
                    color: Colors.grey[600],
                    size: 27,
                  ),
                  backgroundColor: Colors.grey[400],
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'reset password',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                //icon button to log out
                IconButton(
                  onPressed: () {
                    //navigate to login screen
                    Navigator.pushNamed(
                        context, '/resetPassword'
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          // Container(
          //   height: 0.08 * MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   color: Colors.grey[200],
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: 10,
          //       ),
          //       CircleAvatar(
          //         child: FaIcon(
          //           FontAwesomeIcons.bell,
          //           size: 27,
          //           color: Colors.grey[700],
          //         ),
          //         backgroundColor: Colors.grey[400],
          //       ),
          //       SizedBox(
          //         width: 20,
          //       ),
          //       Text('Notification',
          //         //AuthCubit.get(context).socialMediaUser!.name ?? 'reeefy',
          //         style: TextStyle(
          //           fontSize: 17,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       Spacer(),
          //       //icon button to log out
          //       IconButton(
          //         onPressed: () {
          //          //navigate to notifi
          //         },
          //         icon: Icon(
          //           Icons.arrow_forward_ios_rounded,
          //           color: Colors.black,
          //         ),
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 0.08 * MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[200],
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  child: Icon(
                    Icons.help,
                    color: Colors.grey[600],
                    size: 27,
                  ),
                  backgroundColor: Colors.grey[400],
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Help & Support',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                //icon button to log out
                IconButton(
                  onPressed: () {
                    //navigate to login screen
                    Navigator.pushNamed(
                        context, '/aboutUs'
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Container(
            height: 0.08 * MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[200],
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  child: Icon(
                    Icons.info,
                    color: Colors.grey[600],
                    size: 27,
                  ),
                  backgroundColor: Colors.grey[400],
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'about us',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                //icon button to log out
                IconButton(
                  onPressed: () {
                    //navigate to login screen
                    Navigator.pushNamed(
                        context, '/aboutUs'
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),

        ],
      );
    },
  );
}