import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/routiong.dart';
import 'package:uuid/uuid.dart';
//import 'firebase_options.dart';
import 'business_logic/cubit/cubit_observer.dart';
late String intialRoute;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //DioHelper.init();
  await Firebase.initializeApp(  );
  //initialize bloc observer
  FirebaseAuth.instance.authStateChanges().listen((value) {
    if (value != null ) {
      intialRoute = '/homeScrean';
    } else {
      intialRoute = '/loginScreen';
    }
  });
  //init bloc observer
  BlocOverrides.runZoned(() => runApp(const MyApp())
      ,blocObserver: MyBlocObserver());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: intialRoute,
    );
  }
}
