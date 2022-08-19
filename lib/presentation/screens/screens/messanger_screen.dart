import 'package:flutter/cupertino.dart';

Container buildMessangerScreen(BuildContext context) {
  return Container(
    color: CupertinoColors.systemGroupedBackground,
    child: Center(
      child: Text(
        'messanger',
        style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
      ),
    ),
  );
}