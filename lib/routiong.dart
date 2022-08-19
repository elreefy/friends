import 'package:flutter/material.dart';
import 'package:friends/presentation/screens/screens/HomeScreen.dart';
import 'package:friends/presentation/screens/screens/LoginScreen.dart';
import 'package:friends/presentation/screens/screens/createPost.dart';
import 'package:friends/presentation/screens/screens/edit_profile.dart';
import 'package:friends/presentation/screens/screens/register_screen.dart';
import 'package:friends/shared/constants/strings.dart';
//import HomeScrean

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case createPost:
        return MaterialPageRoute(builder: (_) =>
            CreatePostScreen());
        case loginScrean:
        return MaterialPageRoute(builder: (_) =>
            LoginScreen());
        case editProfile:
        return MaterialPageRoute(builder: (_) =>
            EditProfileScreen());
  case registerScreen:
        return MaterialPageRoute(builder: (_) =>
            RegisterScreen());
        case home:
        return MaterialPageRoute(builder: (_) =>
            HomeScreen());

        return _errorRoute();
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorOtp() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('otp'),
        ),
        body: Center(
          child: Text('otp'),
        ),
      );
    });
  }
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}