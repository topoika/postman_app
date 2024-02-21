import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/helper.dart';
import '../models/user.dart' as userModel;
import 'app.controller.dart';
import 'email.controller.dart';

class UserController extends EmailController {
  String? error;
  bool obs = true;
  setObs() => setState(() => obs = !obs);
  setError(val) => setState(() => error = val);

  // create the registered user in the database
  Future<void> registerUser(userModel.User user) async {
    return await getFCM().then((value) async {
      user.deviceToken = value;
      await db.collection(userCol).doc(user.id).set(user.toMap());
    });
  }

// update the user on db
  Future<void> updateUser(userModel.User user) async {
    await db.collection(userCol).doc(user.id).set(user.toMap());
  }

// login user using email and password
  void loginUser(userModel.User user) async {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    try {
      var cridentials = await auth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
      activeUser.value = (await getUserInfo(cridentials.user!.uid))!;
      final deviceToken = await getFCM();
      activeUser.value.deviceToken = deviceToken.toString();
      await updateUser(activeUser.value);
      loader.remove();

      Navigator.pushReplacementNamed(scaffoldKey.currentContext!, "/Pages",
          arguments: 0);
      toastShow(scaffoldKey.currentContext!, "User login successfully", 'suc');
    } catch (e) {
      loader.remove();
      String errorMessage = "An error occurred during login.";
      if (e is FirebaseAuthException) {
        log(e.code);
        if (e.code == 'invalid-email') {
          errorMessage = "Invalid email format.";
        } else if (e.code == 'user-not-found') {
          errorMessage = "User not found.";
        } else if (e.code == 'wrong-password') {
          errorMessage = "Wrong password";
        } else if (e.code == 'too-many-requests') {
          errorMessage = "Too many login attempts. Please try again later.";
        }
      }
      toastShow(scaffoldKey.currentContext!, errorMessage, 'err');
    }
  }

// Register user using email and password
  void register(userModel.User user, profile, id, passport) async {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    try {
      final authResult = await auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
      // await authResult.user!.sendEmailVerification();
      activeUser.value.id = authResult.user!.uid;
      await uploadUserImages(profile, id, passport);
      final deviceToken = await getFCM();
      activeUser.value.deviceToken = deviceToken.toString();
      activeUser.value.createdAt = DateTime.now().toString();
      await registerUser(activeUser.value);
      await getUserInfo(activeUser.value.id!).then((value) {
        activeUser.value = value!;
        loader.remove();
        Navigator.pushReplacementNamed(scaffoldKey.currentContext!, "/Pages",
            arguments: 0);
        toastShow(
            scaffoldKey.currentContext!, "User registered successfully", 'suc');
      });
    } catch (e) {
      loader.remove();
      String errorMessage = "An error occurred during registration.";
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          errorMessage = "This email is already registered.";
        } else if (e.code == 'invalid-email') {
          errorMessage = "Invalid email format.";
        } else if (e.code == 'weak-password') {
          errorMessage = "Password is too weak.";
        } else if (e.code == 'too-many-requests') {
          errorMessage =
              "Too many registration attempts. Please try again later.";
        }
      }
      toastShow(scaffoldKey.currentContext!, errorMessage, 'err');
    }
  }

// Update user infomation
  void updateUserInfo(userModel.User user, profile, id, passport) async {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    try {
      await uploadUserImages(profile, id, passport);
      final deviceToken = await getFCM();
      activeUser.value.deviceToken = deviceToken.toString();
      activeUser.value.updtedAt = DateTime.now().toString();
      await updateUser(activeUser.value);
      loader.remove();
      toastShow(
          scaffoldKey.currentContext!, "User info updated successfully", 'suc');
    } catch (e) {
      loader.remove();
      toastShow(scaffoldKey.currentContext!,
          "Something went wrong, please try again!", 'err');
    }
  }

//Call a clouse function to send email to with the password reset OTP
  void resetPassword(String email) async {
    // check if user exists
    final user =
        await db.collection(userCol).where("email", isEqualTo: email).get();

    if (user.docs.isNotEmpty) {
      Overlay.of(scaffoldKey.currentContext!).insert(loader);
      try {
        await auth.sendPasswordResetEmail(email: email).then((value) {
          loader.remove();
          showSuccessDialog(
              "Password reset link has been sent to the proviced email",
              "",
              "Back to login",
              "/Login");
        });
      } catch (e) {
        loader.remove();
        toastShow(scaffoldKey.currentContext!, "There was an error, try again",
            'err');
      }
    } else {
      toastShow(scaffoldKey.currentContext!,
          "User with this email does not exist, please register", 'err');
    }
  }

// update user password
  void updateUserPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    try {
      String otp = prefs.getString("otpCode")!;

      await auth
          .confirmPasswordReset(
        code: otp,
        newPassword: password,
      )
          .then((value) {
        loader.remove();
        showSuccessDialog(
            "Your Password Reset Succssfully", "Back to login", "", "/Login");
      });
    } catch (e) {
      log(e.toString());
      loader.remove();
      toastShow(scaffoldKey.currentContext!,
          "There was an error updating password, try again", 'err');
    }
  }

// Sign in with google
  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        activeUser.value.email = account.email;
        activeUser.value.username = account.displayName;
        activeUser.value.image = account.photoUrl;
        final GoogleSignInAuthentication gSA = await account.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: gSA.accessToken, idToken: gSA.idToken);
        await auth.signInWithCredential(credential);
        Overlay.of(scaffoldKey.currentContext!).insert(loader);

        final deviceToken = await getFCM();
        activeUser.value.id = auth.currentUser!.uid;
        final user = await getUserInfo(auth.currentUser!.uid);
        if (user != null) {
          activeUser.value.deviceToken = deviceToken.toString();
          activeUser.value = user;
          updateUser(activeUser.value);
          loader.remove();
          Navigator.pushReplacementNamed(scaffoldKey.currentContext!, "/Pages",
              arguments: 0);
          toastShow(
              scaffoldKey.currentContext!, "User login successfully", 'suc');
        } else {
          activeUser.value.deviceToken = deviceToken.toString();
          activeUser.value.createdAt = DateTime.now().toString();
          await registerUser(activeUser.value);
          await getUserInfo(activeUser.value.id!).then((value) {
            activeUser.value = value!;
            loader.remove();
            Navigator.pushReplacementNamed(
                scaffoldKey.currentContext!, "/Pages",
                arguments: 0);
            toastShow(scaffoldKey.currentContext!,
                "User registered successfully", 'suc');
          });
        }
      }
    } catch (e) {
      log(e.toString());
      toastShow(scaffoldKey.currentContext!,
          "An error occurred, please try again", 'err');
    }
  }

// Sign in with facebook
  void signInWithFacebook() async {
    try {
      final account = await FacebookAuth.instance.login();
      if (account.accessToken != null) {
        final AuthCredential credential =
            FacebookAuthProvider.credential(account.accessToken!.token);
        await auth.signInWithCredential(credential);
        Overlay.of(scaffoldKey.currentContext!).insert(loader);
        final deviceToken = await getFCM();
        activeUser.value.id = auth.currentUser!.uid;
        final user = await getUserInfo(auth.currentUser!.uid);
        if (user != null) {
          activeUser.value.deviceToken = deviceToken.toString();
          activeUser.value = user;
          updateUser(activeUser.value);
          loader.remove();
          Navigator.pushReplacementNamed(scaffoldKey.currentContext!, "/Pages",
              arguments: 0);
          toastShow(scaffoldKey.currentContext!, "User registered successfully",
              'suc');
        } else {
          activeUser.value.deviceToken = deviceToken.toString();
          activeUser.value.createdAt = DateTime.now().toString();
          await registerUser(activeUser.value);
          await getUserInfo(activeUser.value.id!).then((value) {
            activeUser.value = value!;
            loader.remove();
            Navigator.pushReplacementNamed(
                scaffoldKey.currentContext!, "/Pages",
                arguments: 0);
            toastShow(scaffoldKey.currentContext!,
                "User registered successfully", 'suc');
          });
        }
      }
    } catch (e) {
      print(e.toString());
      toastShow(scaffoldKey.currentContext!,
          "An error occurred, please try again", 'err');
    }
  }

// Log out
  void logOut() {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    auth.signOut();
    activeUser.value = userModel.User();
    Navigator.pushReplacementNamed(scaffoldKey.currentContext!, "/Login",
        arguments: 0);
    loader.remove();
  }

// Upload registration images
  Future uploadUserImages(File? profile, File? id, File? passport) async {
    if (profile != null) {
      activeUser.value.image = await uploadImageToFirebase(
          profile, "users/${activeUser.value.id}/profle");
    }
    if (id != null) {
      activeUser.value.governmentId = await uploadImageToFirebase(
          id, "users/${activeUser.value.id}/governmentIds");
    }
    if (passport != null) {
      activeUser.value.passport = await uploadImageToFirebase(
          passport, "users/${activeUser.value.id}/passports");
    }
  }
}
