import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/business_logic/news_cubit/auth_cubit.dart';
import 'package:friends/business_logic/news_cubit/auth_cubit.dart';

buildMessangerScreen(BuildContext context) {
  return // listview of row which contain circle avatar and text
    BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          height: .7 * MediaQuery
              .of(context)
              .size
              .height,
          child: ListView.separated(
            itemCount: AuthCubit.get(context).users.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                 // BlocProvider.of<AuthCubit>(context).getUserPosts(
                //      AuthCubit.get(context).users[index].uid);
                  Navigator.pushNamed(context, '/messangerDetailsScreen',
                      arguments:{
                        'user': AuthCubit.get(context).users[index].uid,
                         'name': AuthCubit.get(context).users[index].name,
                        'image': AuthCubit.get(context).users[index].profileImage,
                      });
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        AuthCubit.get(context).users[index].profileImage??'https://www.gstatic.com/webp/gallery/1.jpg'),
                  ),
                  title: Text(
                      '${AuthCubit.get(context).users[index].name}'),
                  subtitle: Text(
                      '${AuthCubit.get(context).users[index].bio}'),
                  ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        );
      },
    );
}