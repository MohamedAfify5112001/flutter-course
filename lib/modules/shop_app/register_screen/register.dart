import 'package:conditional_builder/conditional_builder.dart';
import 'package:course_flutter/layout/shop_app/shop_home_screen/shop_layput_screen.dart';
import 'package:course_flutter/modules/shop_app/register_screen/Register_cubit_shopapp/Register_cubit_shop.dart';
import 'package:course_flutter/modules/shop_app/register_screen/Register_cubit_shopapp/Register_states_shop.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:course_flutter/shared/components/constants.dart';
import 'package:course_flutter/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterShopCubit(),
      child: BlocConsumer<RegisterShopCubit , RegisterShopStates>(
        listener: (context , state) {
          if (state is SuccessfulRegisterShopStates) {
            if (state.modelLogin!.status == true) {
              CacheHelper.putData(
                  key: 'token', value: state.modelLogin!.data!.token)
                  .then((value) {
                if (value) {
                  token = state.modelLogin!.data!.token!;
                  pushAndRemoveUntilPageTo(context, ShopLayout());
                }
              });
            } else if (state.modelLogin!.status == false) {
              CustomSnackBar.error(
                message: state.modelLogin!.message,
                textStyle: TextStyle(fontSize: 5.0, color: Colors.white),
              );
            }
          }
        },
        builder: (context , state){
          var cubit = RegisterShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(23.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER NOW",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Welcome in the offer world in our shop.",
                          style:
                          Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
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
                        ConditionalBuilder(
                          condition: state is! LoadingRegisterShopStates,
                          builder: (context) => defaultMatrialButton(
                              WhenPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text
                                  );
                                }
                              },
                              colorbutton: Colors.deepPurple,
                              text: "Register Now",
                              Borderradius: 30.0),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
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
