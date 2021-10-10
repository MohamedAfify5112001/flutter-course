import 'package:course_flutter/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:course_flutter/modules/social_app/social_register_screen/social_register.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';

class InitialScreenSocial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:
          [
            Image(
              image: AssetImage("assets/images/undraw_Login_re_4vu2.png"),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                children: [
                  defaultMatrialButton(
                      text: "Sign In",
                      colorbutton: Colors.deepPurple,
                      WhenPressed: (){
                        pushAndRemoveUntilPageTo(context, SocialLoginScreen());
                      },
                      Borderradius: 50.0
                  ),
                  SizedBox(height: 30.0,),
                  defaultMatrialButton(
                      text: "Sign Up",
                      colorbutton: Colors.deepPurple,
                      WhenPressed: (){
                        pushAndRemoveUntilPageTo(context, SocialRegisterScreen());
                      },
                      Borderradius: 50.0
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
