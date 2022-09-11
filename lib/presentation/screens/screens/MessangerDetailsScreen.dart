import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/news_cubit/auth_cubit.dart';
import '../../../data/models/SocialMediaUser.dart';

class MessangerDetailsScreen extends StatelessWidget {
  final  user;
  final  name;
  final  image;
  const MessangerDetailsScreen({Key? key,required this.user, this.name, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
       builder: (context) {
         AuthCubit.get(context).getAllMessages(receiverId: user);
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
              appBar: //app bar contain row contain circle avatar of user profile image and
              AppBar(
                title: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(//network image of user profile image
                          image??'https://www.gstatic.com/webp/gallery/1.jpg'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Text(name,
                        style: TextStyle(
                          fontSize: 20,
                        ))
                  ],
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20,),
                  //bzher message list hena
                  Expanded(
                    //   width: MediaQuery.of(context).size.width,
                    //  height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                              controller: ScrollController(),
                              itemBuilder: (context, index){
                                //return sender('${AuthCubit.get(context).messages[index].message}', context);
                                if(user == AuthCubit.get(context).messages[index].receiverId) {
                                  return sender('${AuthCubit.get(context).messages[index].message}', context);
                                } else if(user == AuthCubit.get(context).messages[index].senderId) {
                                  return receiver('${AuthCubit.get(context).messages[index].message}', context);
                                } else {
                                  return Spacer();
                                }
                              },


                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.02,
                                );
                              },
                              itemCount:AuthCubit.get(context).messages.length,
                          ),
                        ),

                  //Spacer(),
                  //bktab il message hena
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300]!,
                          blurRadius: 10,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: AuthCubit.get(context).messageEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type a message',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () async {
                            AuthCubit.get(context).sendMessage(
                                message: AuthCubit.get(context).messageEditingController.text,
                                receiverId: user,
                            );
                         //   AuthCubit.get(context).sendFcmNotification(
                          //      token: user.deviceToken,
                           //     message: AuthCubit.get(context).messageEditingController.text
                           // );
                        await AuthCubit.get(context).sendNotification(
                                receiverId: user,
                                message: AuthCubit.get(context).messageEditingController.text
                             )
                        .then((value) =>
                             AuthCubit.get(context).messageEditingController.clear()
                             );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
}
  Widget sender(String s,context) {
    return   Padding(
      padding: const EdgeInsets.only(
      top: 10,
      bottom: 10,
      right: 10,
      left: 90,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            //width: MediaQuery.of(context).size.width * 0.75,
            //text with box decoration for messages
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Text(
                s,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
            ),
          ),
        ],
      ),
    );
    }
Widget receiver (String message,context) {
  return   Align(
alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          //text with box decoration for messages
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )
          ),
        ),
      ],
    ),
  );
}
}