import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/controllers/app.controller.dart';

import '../../../data/controllers/user.controller.dart';
import '../../../data/helper/helper.dart';
import '../../components/auth/universal.widgets.dart';
import '../../components/buttons.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends StateMVC<PasswordReset> {
  late UserController con;
  _PasswordResetState() : super(UserController()) {
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
            Image.asset("assets/images/logo.png", height: 120),
            const SizedBox(height: 40),
            topColumnText(context, "Password Reset",
                "Enter your new password for ${activeUser.value.email}"),
            const SizedBox(height: 30),
            authInputField(
                context,
                "password.png",
                "New Password",
                "password",
                (val) => activeUser.value.password = val,
                (val) => con.setError(val),
                obs: con.obs,
                setObs: con.setObs),
            authInputField(context, "password.png", "Confirm New Password",
                "confirm_password", (val) {}, (val) => con.setError(val),
                obs: con.obs, setObs: con.setObs),
            buttonOne("Update Password", true, () {
              con.formKey.currentState!.save();
              if (con.formKey.currentState!.validate()) {
                con.updateUserPassword(activeUser.value.password!);
              } else {
                con.error != null
                    ? toastShow(context, con.error.toString(), "err")
                    : null;
              }
            }),
            // const SizedBox(height: 250),
            // GestureDetector(
            //   onTap: () => Navigator.pushReplacementNamed(context, "/Login"),
            //   child: Column(
            //     children: [
            //       Container(
            //         padding: const EdgeInsets.all(14),
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           border: Border.all(width: .8, color: Colors.black),
            //         ),
            //         child: const Icon(Icons.arrow_back,
            //             size: 26, color: Colors.black),
            //       ),
            //       const SizedBox(height: 10.0),
            //       const Text(
            //         "Back to login",
            //         textScaleFactor: 1,
            //         style: TextStyle(
            //           fontSize: 13,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
