import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/news_cubit/auth_cubit.dart';
import '../../../shared/components/components.dart';

buildNoficationScreen(BuildContext context) {
  return BlocConsumer<AuthCubit, AuthState>(
    listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //text Notification
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          //listview of notifications
          Container(
            height: .68* MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              itemCount: AuthCubit.get(context).notifications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                        AuthCubit.get(context).notifications[index].senderProfilePicture??'https://www.gstatic.com/webp/gallery/1.jpg'),
                  ),
                  title: Text('${AuthCubit.get(context).notifications[index].senderName}'+
                      ' send a new massage :'+
                      '${AuthCubit.get(context).notifications[index].content}'),
                  subtitle:Text(
                    getNowDateTime(AuthCubit.get(context).notifications[index].dateTime),
                    style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 25,
                  color: Colors.grey,
                );
              },
            ),
          ),
        ],
      );
    },
  );
}
