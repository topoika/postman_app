import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:otp/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/constants.dart';
import 'app.controller.dart';

class EmailController extends AppController {
  Future<void> sendOTP(String email) async {
    String otpCode = generateRandomCode();
    await _saveCodeInPreferences(otpCode, email);
    await sendEmail(email, otpCode);
    await auth.sendPasswordResetEmail(email: email);
    print('OTP sent successfully!');
  }

  String generateRandomCode() {
    return OTP.generateTOTPCodeString(
        "SECRET_KEY", DateTime.now().millisecondsSinceEpoch,
        length: 4);
  }

  Future<void> _saveCodeInPreferences(String code, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("otpCode", code);
  }

  Future<void> sendEmail(String recipient, String otpCode) async {
    String username = "EMAIL";
    String password = "PASSWORD";

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, appName)
      ..recipients.add(recipient)
      ..subject = 'Password Reset OTP for $appName'
      ..text =
          'Your password reset OTP code is: $otpCode use it to reset your password';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
    } on MailerException catch (e) {
      print('Message not sent. ${e.message}');
    }
  }

  // Images operations
}
