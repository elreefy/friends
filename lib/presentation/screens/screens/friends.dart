import 'package:flutter/cupertino.dart';

Container buildFriendsScreens(BuildContext context) {
  return Container(
    color: CupertinoColors.systemGroupedBackground,
    child: Center(
      child: Text(
        'Friends',
        style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
      ),
    ),
  );
}