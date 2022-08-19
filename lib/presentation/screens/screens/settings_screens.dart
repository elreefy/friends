import 'package:flutter/cupertino.dart';

Container buildSettings(BuildContext context) {
  return Container(
    color: CupertinoColors.systemGroupedBackground,
    child: Center(
      child: Text(
        'settings',
        style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
      ),
    ),
  );
}