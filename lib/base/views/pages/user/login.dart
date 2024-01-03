import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/user.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../components/auth/universal.widgets.dart';
import '../../components/buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<LoginPage> {
  late UserController con;
  _LoginPageState() : super(UserController()) {
    con = controller as UserController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      body: Form(
        key: con.formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          children: [
            const SizedBox(height: 30),
            Image.asset("assets/images/logo.png", height: 90),
            const SizedBox(height: 50),
            topColumnText(context, "Welcome Back", "Please sign in here"),
            const SizedBox(height: 30),
            authInputField(
                context,
                "email.png",
                "Email Address",
                "email",
                (val) => activeUser.value.email = val,
                (val) => con.setError(val)),
            authInputField(
                context,
                "password.png",
                "Password",
                "password",
                (val) => activeUser.value.password = val,
                (val) => con.setError(val),
                obs: con.obs,
                setObs: con.setObs),
            buttonOne("Login", true, () {
              if (con.formKey.currentState!.validate()) {
                con.formKey.currentState!.save();
                con.loginUser(activeUser.value);
              } else {
                con.error != null
                    ? toastShow(context, con.error.toString(), "err")
                    : null;
              }
            }),
            const LoginOrSignUpText(link: "Forgot Password?", main: ""),
            const SizedBox(height: 50),
            const Row(
              children: <Widget>[
                Expanded(
                  child: Divider(
                    color: Colors.black,
                    thickness: .5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "OR",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 13),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.black,
                    thickness: .5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    con.signInWithGoogle();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      border: Border.all(color: greenColor, width: .8),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.asset(
                      "assets/icons/google.png",
                      height: 25,
                      width: 25,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    con.signInWithFacebook();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      border: Border.all(color: greenColor, width: .8),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.asset(
                      "assets/icons/facebook.png",
                      height: 25,
                      width: 25,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            const LoginOrSignUpText(
                link: "Sign up", main: "Don't have an account? "),
          ],
        ),
      ),
    );
  }
}
