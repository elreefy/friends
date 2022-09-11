import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/business_logic/news_cubit/social_cubit.dart';
import 'package:friends/routiong.dart';
import 'package:friends/shared/components/components.dart';
import 'package:friends/shared/constants/my_colors.dart';
import 'package:friends/shared/constants/strings.dart';
import 'package:uuid/uuid.dart';
//import 'firebase_options.dart';
import 'business_logic/cubit/cubit_observer.dart';
import 'business_logic/news_cubit/auth_cubit.dart';
import 'data/api/dio_helper.dart';
import 'data/cashe_helper.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('[firebaseMessagingBackgroundHandler] : ${message.data.toString()}');

  //showToast(msg:'onBackgroundMessage', state: ToastStates.SUCCESS);
}
late String intialRoute;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Firebase.initializeApp();
  //firebase messaage grt token and save it in tooken variable
    await CashHelper.init();
  FirebaseMessaging.onMessage.listen((message) async {
    print("onMessage: ${message.data.toString()}");
   // showToast(msg:'onMessage', state: ToastStates.SUCCESS);
  });
FirebaseMessaging.onMessageOpenedApp.listen((message) async {
  print("onMessageOpenedApp: ${message.data.toString()}");
  //showToast(msg:'onMessageOpenedApp', state: ToastStates.SUCCESS);
});
FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.getToken().then((deviceToken) async {
    print("deviceToken: $deviceToken");
    await CashHelper.saveToken(deviceToken);
  });

    //Todo: add this to the build method in the main.dart file
     uId = await CashHelper.getData(key: 'uId');

    //print('fer uId : $uId');
    //  uId = '2fQtUdulZgYWBcQSnioxQuVuPED2';
    //roro uid
    // uId = 'haoKchb4dvbbevAjs9vwKoVaB8i1';
   print('\n'
       '\n'
       '\n'
       '\n'
       '\n'
       '\n'
       '\n'
       );
//print('firebase.currentuser : ${FirebaseAuth.instance.currentUser!.email}');
//print('firebase.currentuser : ${FirebaseAuth.instance.currentUser!.phoneNumber}');
  print(uId);

  //if firebase user is null then go to the login screen
  if (uId != null) {
   intialRoute = '/MyCustomWidget';
  } else {
    intialRoute = '/loginScreen';
  }
   BlocOverrides.runZoned(() => runApp(const MyApp())
       ,blocObserver: MyBlocObserver()
   );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider<SocialCubit>(
          create: (context) => SocialCubit(),
        ),
        BlocProvider<AuthCubit>(
          //TODO: sign out sheeeeeeeeeeeeeeeeeeeeeeeeeel
          create: (context) => AuthCubit()
            ..getFriendsName()
            ..getAllUsers()
            ..getAllNotifications()
            ..getAllFriendRequests()
            ..getProfileImageFromCache()
            ..getPendingFriendRequestsCount()
        ),

      ],
      child: MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: //white color
          MyColors.primaryColor,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: intialRoute,
  //    initialRoute: intialRoute,
      ),
    );
  }
}
