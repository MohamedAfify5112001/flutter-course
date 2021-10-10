import 'package:conditional_builder/conditional_builder.dart';
import 'package:course_flutter/modules/social_app/social_register_screen/social_register_cubits/social_register_cubit.dart';
import 'package:course_flutter/modules/social_app/social_register_screen/social_register_cubits/social_register_states.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SocialRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialRegisterCubit.get(context);
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
                            "assets/images/undraw_Mobile_payments_re_7udl.png"),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultTextInputField(
                          controller: nameController,
                          labelText: "Name",
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your name";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 23.0,
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
                      defaultTextInputField(
                          controller: phoneController,
                          labelText: "Phone",
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your phone";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 32.0,
                      ),
                      defaultMatrialButton(
                          WhenPressed: () {
                            if (formKey.currentState!.validate()) {
                              /*cubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text);*/
                            }
                          },
                          colorbutton: Colors.deepPurple,
                          text: "Register Now",
                          Borderradius: 30.0),
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
