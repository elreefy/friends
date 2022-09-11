import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/shared/components/components.dart';
import 'package:friends/shared/constants/strings.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../business_logic/news_cubit/auth_cubit.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
     AuthCubit cubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
     // backgroundColor: Constants.kBlackColor,
      extendBody: true,
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: <Widget>[
            SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    SearchFieldWidget(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                    //  isSearching: false,
                      cubit: cubit,
                    ),
                    const SizedBox(height: 24),
                    //list view for predicted list of movies vertical
                    if (state is SearchForUserSuccess || cubit.searchedUser.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: cubit.searchedUser.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  cubit.searchedUser[index].name ??
                                      'hi'),
                              subtitle: Text(
                                  cubit.searchedUser[index].bio! ),
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          cubit.searchedUser[index]
                                              .profileImage ??firstProfileImage
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                              trailing: InkWell(
                                    onTap: (){
                                      cubit.sendFriendRequest(
                                      receiverId: cubit.searchedUser[index].uid!).then((value) {
                                        showToast2(
                                            msg:  'Friend Request Sent',
                                            state: ToastStates.SUCCESS);
                                      });
                                    },
                                    child: Container(
                                    height: 30,
                                      width: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                    child: Text(
                                      'Add Friend',
                                      style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                   ),
                                  ),
                                 ),

                              onTap: () async {
                                await AuthCubit.get(context).sendNotification(
                                    receiverId: cubit.searchedUser[index].uid!,
                                    message: '${cubit.searchedUser[index].name!}send a friend request to youuu'
                                );
                                AuthCubit.get(context).myPosts.
                                clear();
                                Navigator.pushNamed(context, '/userProfile',arguments: cubit.searchedUser[index]);
                               // Navigator.pushNamed(context, '/userProfile',arguments: cubit.searchedUser[index]);
                              },
                            );
                          },
                        ),
                      ),

                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   scrollDirection: Axis.vertical,
                    //   itemCount: cubit.PredictedMoviesList.length,
                    //   itemBuilder: (context, index) {
                    //     return InkWell(
                    //       onTap: () {
                    //         Navigator.of(context).pushNamed(
                    //             '/movieDetails',
                    //             arguments: cubit.PredictedMoviesList[index]
                    //         );
                    //       },
                    //       child: Stack(
                    //         children: [
                    //           Container(
                    //
                    //           ),
                    //           Container(
                    //             margin: EdgeInsets.all(20.0),
                    //             height: 160,
                    //             width: screenWidth*.3,
                    //             child: Image.network(
                    //               MovieCubit.get(context)
                    //                   .topMoviesList[index]
                    //                   .image,
                    //               height: 160,
                    //               width: 142,
                    //             ),
                    //           ),
                    //         ],
                    //
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                )),
          ],
        ),
      ),

    );
  },
);
  }

  SearchFieldWidget({required EdgeInsets padding ,required AuthCubit cubit}) {
    return Padding(
      padding: padding,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.search,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
              onTap: (){
                //toogle for first click only
                 cubit.toggleSearchIcon();
                },
                controller: cubit.searchController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    cubit.searchForUser(searchKey: value);
                  } else {
                    cubit.searchedUser = [];
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (cubit.isSearching)
              IconButton(
                onPressed: () {
                cubit.toggleSearchIcon();
                cubit.searchController.clear();
                  },
                icon: Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
}
}
