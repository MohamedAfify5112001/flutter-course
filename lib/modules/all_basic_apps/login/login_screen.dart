import 'package:course_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailDataInField = TextEditingController();
  var PasswordDataInField = TextEditingController();
  bool showPassword = true;
  GlobalKey<FormState> KeyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome in Login Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: KeyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25.0),
                  defaultTextInputField(
                    controller: emailDataInField,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Email is Required";
                      }
                      return null;
                    },
                    labelText: "Email Address",
                    prefixIcon: Icons.email,
                  ),
                  SizedBox(height: 12.0),
                  defaultTextInputField(
                    controller: PasswordDataInField,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Password is Required";
                      }
                      return null;
                    },
                    labelText: "Password",
                    prefixIcon: Icons.lock,
                    suffixIcon:
                        showPassword ? Icons.visibility : Icons.visibility_off,
                    isPasswordSecure: showPassword,
                    showPassword: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                  SizedBox(height: 12.0),
                  defaultMatrialButton(
                      text: "LOiGN",
                      WhenPressed: () {
                        if (KeyForm.currentState!.validate()) {
                          print(emailDataInField.text);
                          print(PasswordDataInField.text);
                        }
                      },
                      isUpperCase: true,
                      Borderradius: 50.0),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don\'t have account?"),
                      TextButton(onPressed: () {}, child: Text("Register Now!"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
