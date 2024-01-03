import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/user.controller.dart';
import '../../../data/helper/helper.dart';
import '../../components/auth/universal.widgets.dart';
import '../../components/buttons.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends StateMVC<ForgetPassword> {
  late UserController con;
  _ForgetPasswordState() : super(UserController()) {
    con = controller as UserController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      body: Form(
        key: con.formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          children: [
            const SizedBox(height: 30),
            Image.asset("assets/images/logo.png", height: 90),
            const SizedBox(height: 40),
            topColumnText(context, "Forgot Password?",
                "Enter your email address so that we can send you the access code."),
            const SizedBox(height: 30),
            authInputField(
                context,
                "email.png",
                "Email Address",
                "email",
                (val) => activeUser.value.email = val,
                (val) => con.setError(val)),
            buttonOne("Send Code", true, () {
              if (con.formKey.currentState!.validate()) {
                con.formKey.currentState!.save();
                con.resetPassword(activeUser.value.email!);
              } else {
                con.error != null
                    ? toastShow(context, con.error.toString(), "err")
                    : null;
              }
            }),
            const SizedBox(height: 250),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, "/Login"),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: .8, color: Colors.black),
                    ),
                    child: const Icon(Icons.arrow_back,
                        size: 26, color: Colors.black),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    "Back to login",
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
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
