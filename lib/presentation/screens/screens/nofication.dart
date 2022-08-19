import 'package:flutter/cupertino.dart';

Container buildNoficationScreen(BuildContext context) {
  return Container(
    color: CupertinoColors.systemGroupedBackground,
    child: Center(
      child: Text(
        'nofication',
        style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
      ),
    ),
  );
}