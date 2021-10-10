import 'package:conditional_builder/conditional_builder.dart';
import 'package:course_flutter/modules/shop_app/login_screen/login_cubit_shopapp/login_states_shop.dart';
import 'package:course_flutter/modules/social_app/social_login_screen/social_login_cubit/social_login_cubit.dart';
import 'package:course_flutter/modules/social_app/social_login_screen/social_login_cubit/social_login_states.dart';
import 'package:course_flutter/modules/social_app/social_register_screen/social_register.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is ErrorSocialLoginStates) {
            showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: "This Credential is\'n exist",
                textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            );
          }
          if (state is SuccessfulSocialLoginStates) {
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                message: "Login Successful",
                textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = SocialLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(23.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage(
                            "assets/images/undraw_Mobile_login_re_9ntv.png"),
                        //image: AssetImage("assets/images/undraw_Access_account_re_8spm.png"),
                        fit: BoxFit.cover,
                        height: 330.0,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultTextInputField(
                          controller: emailController,
                          labelText: "Email Address",
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 23.0,
                      ),
                      defaultTextInputField(
                          controller: passwordController,
                          labelText: "Password",
                          isPasswordSecure: cubit.isSecure,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: cubit.iconForPassword,
                          showPassword: () {
                            cubit.changeIcon();
                          },
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 32.0,
                      ),
                      defaultMatrialButton(
                          WhenPressed: () {
                            if (formKey.currentState!.validate()) {
                              /*cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);*/
                            }
                          },
                          colorbutton: Colors.deepPurple,
                          text: "Login Now",
                          Borderradius: 30.0),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Do not have an account?",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                          TextButton(
                            onPressed: () {
                              pushAndRemoveUntilPageTo(
                                  context, SocialRegisterScreen());
                            },
                            child: Text("REGISTER"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
