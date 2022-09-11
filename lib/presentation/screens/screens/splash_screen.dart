import 'dart:async';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/business_logic/news_cubit/auth_cubit.dart';
import 'package:friends/presentation/screens/screens/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  double _opacity = 0;
  bool _value = true;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )
      ..addStatusListener(
            (status) {
          if (status == AnimationStatus.completed) {
            Navigator.of(context).pushReplacementNamed(
              '/home',
            );
            Timer(
              Duration(milliseconds: 300),
                  () {
                scaleController.reset();
              },
            );
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
        _value = false;
      });
    });
    Timer(Duration(milliseconds: 2000), () {
      setState(() {
        scaleController.forward();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scaleController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.3,
              ),
              Image.asset(
                'lib/Light Logo.png',
                fit: BoxFit.cover,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget page;
  final Widget route;

  ThisIsFadeRoute({ required this.page, required this.route})
      : super(
    pageBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,) =>
    page,
    transitionsBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,) =>
        FadeTransition(
          opacity: animation,
          child: route,
        ),
  );
}

