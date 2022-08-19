import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/news_cubit/auth_cubit.dart';
import '../../../shared/constants/my_colors.dart';
class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
  //emaail controoler and password controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    final width = mediaQuery.size.width;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SignUpSuccess) {
          Navigator.pushReplacementNamed(
              context, '/home');
        } else if (state is SignUpError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }else if(state is UserCreateSuccess) {
          Navigator.pushReplacementNamed(
              context, '/home');
        }else if(state is UserCreateError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
      },
      builder: (context, state) {
       var cubit =AuthCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            width: width,
            height: height,
            child: Stack(
              children: [
                Positioned(
                  width: width,
                   height: height*0.4,
                  //height: 300.0,
                  child: //container contain text and sub text
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/background.jpeg'),
                        fit: BoxFit.cover,
                      ),                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'REGISTER\n',
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
                            'create a new account to communiacate with your friends',
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
                  padding:  EdgeInsets.only(
                    top: height * 0.32,
                  ),
                  child: Positioned(
                    width: width,
                    height: height * 0.68,
                    child: //TextField to enter username and password
                    Container
                      (
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: //TextField to enter username and password and phone number and email address and password and confirm password and submit button with prefix icons
                      Container(
                        margin: EdgeInsets.only(
                          top: height * 0.05,
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: MyColors.kBlackColor,
                                    ),
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                      color: MyColors.kBlackColor,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: MyColors.kBlackColor,
                                    ),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      color: MyColors.kBlackColor,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: MyColors.kBlackColor,
                                    ),
                                    hintText: 'Phone Number',
                                    hintStyle: TextStyle(
                                      color: MyColors.kBlackColor,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: TextField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: MyColors.kBlackColor,
                                    ),
                                    hintText: 'password',
                                    hintStyle: TextStyle(
                                      color: MyColors.kBlackColor,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                    cubit.signUp(
                                      user: emailController.text,
                                     password:  passwordController.text,
                                    );
                                    //TODO:
                                    // pu



                                  },
                                  child: Text(
                                    'Sign UP',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                ),
                              ),
                            ),
                            //Text alredy have an account
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      color: MyColors.kBlackColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                  //text sign in using inkwell to navigate to login screen
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/login_screen');

                                    },
                                    child: Text(
                                      'Sign In',
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
                          ],
                        ),
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
}