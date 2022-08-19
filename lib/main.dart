import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/business_logic/news_cubit/social_cubit.dart';
import 'package:friends/routiong.dart';
import 'package:friends/shared/constants/my_colors.dart';
import 'package:friends/shared/constants/strings.dart';
import 'package:uuid/uuid.dart';
//import 'firebase_options.dart';
import 'business_logic/cubit/cubit_observer.dart';
import 'business_logic/news_cubit/auth_cubit.dart';
import 'data/cashe_helper.dart';
late String intialRoute;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //DioHelper.init();
  await Firebase.initializeApp();
  await CashHelper.init();
  //Todo: add this to the build method in the main.dart file
   uId =  CashHelper.getString(key: 'uId');
   //uId = 'lTv85StmJJaj8773HsB77dtj1aT2';

   print(uId);
   print('\n'
       '\n'
       '\n'
       '\n'
       '\n'
       '\n'
       '\n'
       );
   //if firebase user is null then go to the login screen
  if (uId != null) {
   intialRoute = '/home';
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
          create: (context) => AuthCubit()..getAllPosts(),
        ),
      ],
      child: MaterialApp(
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
