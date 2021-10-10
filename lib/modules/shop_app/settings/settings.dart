import 'package:conditional_builder/conditional_builder.dart';
import 'package:course_flutter/layout/shop_app/shop_cubit/cubit.dart';
import 'package:course_flutter/layout/shop_app/shop_cubit/states.dart';
import 'package:course_flutter/modules/shop_app/login_screen/login_screen.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:course_flutter/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class ShopSettings extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit , ShopHomeState>(
      listener: (context , state){
      },
      builder: (context , state){
        nameController.text = ShopHomeCubit.get(context).userModel!.data!.name!;
        emailController.text = ShopHomeCubit.get(context).userModel!.data!.email!;
        phoneController.text = ShopHomeCubit.get(context).userModel!.data!.phone!;
        return ConditionalBuilder(
          condition: ShopHomeCubit.get(context).userModel != null,
          builder: (context)  => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children:
                [
                  SizedBox(height: 25.0,),
                  Image(
                    image: AssetImage("assets/images/undraw_Login_re_4vu2.png"),
                  ),
                  SizedBox(height: 25.0,),
                  Column(
                    children:
                    [
                      defaultTextInputField(
                          controller: nameController,
                          labelText: "Name",
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.text
                      ),
                      SizedBox(height: 22.0,),
                      defaultTextInputField(
                          controller: emailController,
                          labelText: "Email",
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress
                      ),
                      SizedBox(height: 22.0,),
                      defaultTextInputField(
                        controller: phoneController,
                        labelText: "Phone",
                        prefixIcon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 30.0,),
                      defaultMatrialButton(
                          text: "Log Out",
                          WhenPressed: (){
                            ShopHomeCubit.get(context).logoutFromWeb();
                            CacheHelper.removeData('token').then((value){
                              if(value){
                                pushAndRemoveUntilPageTo(context, LoginScreen());
                              }
                            });
                          },
                          Borderradius: 30.0,
                          colorbutton: Colors.deepPurple
                      ),
                      SizedBox(height: 20.0,),
                      defaultMatrialButton(
                          text: "Update Your Profile",
                          WhenPressed: (){
                            ShopHomeCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          },
                          Borderradius: 30.0,
                          colorbutton: Colors.deepPurple
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          fallback: (context)  => CircularProgressIndicator(),
        );
      },
    );
  }
}
