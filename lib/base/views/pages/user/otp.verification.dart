import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/helper/helper.dart';
import '../../components/auth/universal.widgets.dart';
import '../../components/buttons.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  final TextEditingController code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        children: [
          const SizedBox(height: 30),
          Image.asset("assets/images/logo.png", height: 120),
          const SizedBox(height: 40),
          topColumnText(context, "Forgot Password?",
              "Enter your email address so that we can send you the access code."),
          const SizedBox(height: 30),
          PinCodeTextField(
            appContext: context,
            length: 4,
            pastedTextStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16 / MediaQuery.of(context).textScaleFactor),
            textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16 / MediaQuery.of(context).textScaleFactor),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            keyboardType: TextInputType.number,
            cursorWidth: 1,
            cursorColor: Colors.black,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            boxShadows: const [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
            controller: code,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.circle,
                fieldWidth: 65,
                borderWidth: .1,
                activeBorderWidth: 1,
                inactiveBorderWidth: 0.01,
                selectedBorderWidth: 1,
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
                inactiveFillColor: Colors.grey.withOpacity(.6),
                selectedFillColor: Colors.white,
                selectedColor: Colors.black,
                disabledColor: Colors.grey,
                activeFillColor: Colors.white),
          ),
          buttonOne("Submit", code.text.length == 4, () async {
            await verifyCode().then((value) {
              if (value) {
                toastShow(context, "OTP code verified successfully", 'suc');
                Navigator.pushReplacementNamed(context, "/PasswordReset");
              } else {
                toastShow(context, "OTP code is invalid", 'err');
              }
            });
          }),
          const SizedBox(height: 250),
          GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, "/ForgetPassword"),
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
                  "Back",
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
    );
  }

  Future<bool> verifyCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String otpCode = prefs.getString("otpCode")!;
    return otpCode == code.text.trim();
  }
}
