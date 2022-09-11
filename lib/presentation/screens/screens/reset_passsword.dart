import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/news_cubit/auth_cubit.dart';
import '../../../shared/components/components.dart';

class ResetPasswordScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var resetKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(
      listener: (context,state) {},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              child: Column(
                children: [
                  Text('Change Password',
                    style: TextStyle(color: Colors.black,fontSize: 50,fontWeight: FontWeight.bold),),
                  Text('Enter Associated Email',
                    style: TextStyle(color: Colors.black,fontSize: 20),),
                  SizedBox(height: 40,),
                  defaultFormField2(
                      context: context,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email Address',
                      prefix: Icons.email,
                      validate: (value)
                      {
                        if(value!.isEmpty)
                          return 'This field must be filled';
                      }
                  ),
                  SizedBox(height: 20,),
                  state is ResetPasswordLoading?
                  Center(child: CircularProgressIndicator())
                      :defaultButton(
                    text: 'Change Password',
                    onTap: () {
                      if (resetKey.currentState!.validate()) {
                        AuthCubit.get(context).resetPassword(
                          email: emailController.text,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
