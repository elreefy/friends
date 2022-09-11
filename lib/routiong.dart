import 'package:flutter/material.dart';
import 'package:friends/data/models/SocialMediaUser.dart';
import 'package:friends/presentation/screens/screens/HomeScreen.dart';
import 'package:friends/presentation/screens/screens/LoginScreen.dart';
import 'package:friends/presentation/screens/screens/MessangerDetailsScreen.dart';
import 'package:friends/presentation/screens/screens/about-us-screen.dart';
import 'package:friends/presentation/screens/screens/createPost.dart';
import 'package:friends/presentation/screens/screens/edit_profile.dart';
import 'package:friends/presentation/screens/screens/friend_profile_screen.dart.dart';
import 'package:friends/presentation/screens/screens/register_screen.dart';
import 'package:friends/presentation/screens/screens/reset_passsword.dart';
import 'package:friends/presentation/screens/screens/search-screen.dart';
import 'package:friends/presentation/screens/screens/splash_screen.dart';
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
        case messangerDetailsScreen:
          final  args = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (_) =>
            MessangerDetailsScreen(
              user: args['user'],
              name: args['name'],
              image: args['image'],
            ));
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
        case resetPassword:
        return MaterialPageRoute(builder: (_) =>
            ResetPasswordScreen());
        case aboutUs:
        return MaterialPageRoute(builder: (_) =>
            AboutMe());
        case search:
        return MaterialPageRoute(builder: (_) =>
            SearchScreen());

        case myCustomWidget:
        return MaterialPageRoute(builder: (_) =>
            SplashScreen());
        case userProfile:
          final SocialMediaUser args = settings.arguments as SocialMediaUser;
         return MaterialPageRoute(builder: (_) =>
             FriendProfileScreen(
               userModel: args,
            ));
      default:

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