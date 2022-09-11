import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:friends/business_logic/news_cubit/auth_cubit.dart';
import 'package:friends/business_logic/news_cubit/auth_cubit.dart';
import 'package:friends/shared/components/components.dart';
import 'package:friends/shared/constants/my_colors.dart';
import 'package:friends/shared/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/cashe_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //use media query to get the height and width of the screen
    final mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    final width = mediaQuery.size.width;
    //form key for the text fields
    final formKey = GlobalKey<FormState>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        //if state is login success show toast else show error
        if (state is FireBaseLoginSuccess) {
          showToast2(
            msg: 'Login Success',
            state: ToastStates.SUCCESS,
          );

        } else if (state is FireBaseLoginError) {
          showToast2(
            msg:  state.error,
            state: ToastStates.ERROR,
          );
        }
        if (state is GoogleLoginSuccess) {
          showToast2(
            msg: 'Login Success',
            state: ToastStates.SUCCESS,
          );
          CashHelper.setString(key: 'uId', value: state.uId);
          Navigator.pushNamed(context, '/home');
        }
        if (state is GoogleLoginError) {
          showToast2(
            msg: state.error,
            state: ToastStates.ERROR,
          );
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        if (state is SignUpSuccess) {
          showToast2(
            msg: 'plz verify your email',
            state: ToastStates.WARNING,
          );
          CashHelper.setString(key: 'uId', value:state.uId);
          Navigator.pushNamed(context, '/home');
        }
         if (state is FireBaseLoginSuccess) {
          showToast2(
            msg: 'Login Success',
            state: ToastStates.SUCCESS,
          );
           CashHelper.setString(key: 'uId', value: state.uId);
           Navigator.pushNamed(context, '/home');
         }
          if (state is FireBaseLoginError) {
          showToast2(
            msg: state.error,
            state: ToastStates.ERROR,
          );
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            width: width,
            height: height,
            child: Stack(
              children: [
                Positioned(
                  width: width,
                  // height: height*0.3,
                  height: 320.0,
                  child: //container contain text and sub text
                  Container(
                    //background image
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/background.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            'WELCOME\n'
                                'BACK!!',
                            style: TextStyle(
                              color: MyColors.kWhiteColor,
                              fontFamily: 'Cairo',
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //  SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'Login to your account to communiacate with your friends',
                            style: TextStyle(
                              fontSize: 20,
                              color: MyColors.kWhiteColor,
                              //fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 300,
                  ),
                  child: Positioned(
                    width: width,
                    height: height * 0.7,
                    child: //TextField to enter username and password
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Expanded(
                            flex: 2,
                            child: myTextFormField(
                              context: context,
                              isEmail: true,
                              isPassword: false,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Expanded(
                            flex: 2,
                            child: myTextFormField(
                              context: context,
                              isEmail: false,
                              isPassword: true,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: width,
                              height: 50,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                color: Colors.blue,
                                onPressed: () {
                                    cubit.login(
                                      user: cubit.emailController.text,
                                      password: cubit.passwordController.text,
                                    );
                                    //showToast(text: , state: ToastStates.ERROR);
                                 // cubit.sendVerificationCode();

                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //
                          const SizedBox(height: 15),
                          Expanded(
                            flex: 1,
                            child: Text('or login in with',
                                style: TextStyle(
                                  color: MyColors.kGreyColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          //   const SizedBox(height: 15),
                          //row contain facebook and google icons
                          Expanded(
                            flex: 2,
                            child: _buidSocialMediaIcons(
                             context: context,
                              cubit: cubit,
                            ),
                          ),
                          //   const SizedBox(height: 15),
                          //text to register
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                    color: MyColors.kGreyColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //inkwel text to register
                                InkWell(
                                  onTap: () {
                                    //navigate to register screen push with replacement
                                    Navigator.pushReplacementNamed(
                                        context, '/register_screen');
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),


                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  //text form field to enter username and password with validation and hint text and icon and controller and suffix icon for password visibility and form key for validation


  Widget myTextFormField({
    required BuildContext context,
    bool isEmail = false,
    bool isPassword = false,
  }) {
    final cubit = AuthCubit.get(context);
    return TextFormField(
      controller: isEmail
          ? cubit.emailController
          : cubit.passwordController,
      obscureText: isPassword ? !cubit.isPasswordVisible : false,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  cubit.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  cubit.togglePasswordVisibility();
                },
              )
            : null,
        hintText: isEmail ? 'Email' : 'Password',
        hintStyle: TextStyle(
          color: MyColors.kGreyColor,
          fontSize: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: MyColors.kGreyColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: MyColors.kGreyColor,
          ),
        ),
      ),
    );
  }


  Widget _buidSocialMediaIcons({required BuildContext context,required AuthCubit cubit}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(FontAwesomeIcons.facebook),
          onPressed: () {
            launch('https://www.facebook.com/');
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.twitter),
          onPressed: () {
            launch('https://twitter.com/');
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.googlePlusG),
          onPressed: () {
            //Todo :5le balek feh local cubit 3lt
            cubit.signInWithGoogle().then((value)
            {

            });
          },
        ),
      ],
    );
  }
}
