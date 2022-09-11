import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/business_logic/news_cubit/auth_cubit.dart';
import 'package:friends/data/models/FriendRequestModel.dart';
import 'package:friends/shared/components/components.dart';
import 'package:friends/shared/constants/strings.dart';
import 'package:iconsax/iconsax.dart';

buildFriendsRequestList(BuildContext context) {
  return Builder(

    builder: (BuildContext context) {
     // AuthCubit.get(context).getAllFriendRequests();
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ListView.separated(

            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return  //if friend request status is pending
                AuthCubit.get(context).friendRequests[index].status == 'pending'
                    ?buildFriendRequestItem(
                    AuthCubit.get(context).friendRequests[index], context):
                Container(height: 1,);
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: AuthCubit.get(context).friendRequests.length,
          );
        },
      );
    },
  );
}
buildMyFriendsList(BuildContext context) {
  return Builder(

    builder: (BuildContext context) {
      AuthCubit.get(context).getAllFriendRequests();
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Expanded(
            //height: MediaQuery.of(context).size.height * 0.3,
           // width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return  //if friend request status is pending
                  AuthCubit.get(context).friendRequests[index].status == 'accepted'
                      ?buildFriendItem(
                      AuthCubit.get(context).friendRequests[index], context):
                  Container();
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: AuthCubit.get(context).friendRequests.length,
            ),
          );
        },
      );
    },
  );
}

buildFriendRequestItem(FriendRequestModel friendRequest, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    //padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              friendRequest.senderPhotoUrl??
              'https://www.gstatic.com/webp/gallery/1.jpg'),
          ),

        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             friendRequest.senderName!,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
             // 'ahemd hossam@yahoo.com',
              friendRequest.senderEmail!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Spacer(),
        Row(
          children: [
            IconButton(
              onPressed: () {
                AuthCubit.get(context).acceptFriendRequest(
                    senderId: AuthCubit.get(context).socialMediaUser!.uid!,
                ).then((value) {
                //show toast friendrequest name is now your friend
                 showToast2(msg: '${friendRequest.senderName} is now your friend',
                     state: ToastStates.SUCCESS,
                   seconds: 4,
                  );
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
               AuthCubit.get(context).deleteFriendRequest(
               senderId: friendRequest.senderId!
               );
              },
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
buildFriendItem(FriendRequestModel friendRequest, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    //padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              friendRequest.senderPhotoUrl??
              'https://www.gstatic.com/webp/gallery/1.jpg'),
          ),

        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             friendRequest.senderName??'reeefy',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Spacer(),
        //container contain row of icon and text
        InkWell(
          onTap: () {
            //navigate to chat screen
            Navigator.pushNamed(context, '/messangerDetailsScreen',
                arguments: friendRequest.senderId);
          },
          child: Container(
            padding: EdgeInsets.all(1),
            color: Colors.grey[300],
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              children: [
                Text(
                  'Message',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    AuthCubit.get(context).deleteFriendRequest(
                        senderId: friendRequest.senderId!
                    );
                  },
                  icon: Icon(
                    Iconsax.message4,
                  ),
                ),
                //text message
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
buildFriendText({text}){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      //
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
);
}