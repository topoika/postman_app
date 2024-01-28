import 'package:flutter/material.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/helper/constants.dart';

Widget topColumnText(context, String heading, String description) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: <Widget>[
          Text(
            heading,
            textScaleFactor: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            description,
            textScaleFactor: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );

class LoginOrSignUpText extends StatelessWidget {
  const LoginOrSignUpText({Key? key, required this.link, required this.main})
      : super(key: key);
  final String main, link;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          String route = "";
          if (link == "Login") {
            route = "/Login";
          } else if (link == "Sign up") {
            route = "/Register";
          } else {
            route = "/ForgotPassword";
          }
          Navigator.pushReplacementNamed(context, route);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              main,
              textScaleFactor: 1,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              link,
              textScaleFactor: 1,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget profileItem(context, txt, desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          txt,
          textScaleFactor: 1,
          style: const TextStyle(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 3),
        Text(
          desc,
          textScaleFactor: 1,
          style: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

List<String> errors = [];

Widget authInputField(context, image, hint, type, onSaved, onValidate,
    {bool obs = false, Function? setObs}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
    margin: const EdgeInsets.symmetric(vertical: 7),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(40.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/icons/$image", height: 18),
        const SizedBox(width: 13),
        Expanded(
          child: TextFormField(
            autofillHints: [type],
            onSaved: (val) => onSaved(val),
            validator: (value) {
              String? error;
              switch (type) {
                case "email":
                  error = validateEmail(value!);
                  addError(error);
                case "username":
                  error = value!.isEmpty ? "Username is required" : null;
                  addError(error);
                case "password":
                  error = validatePassword(value!);
                  addError(error);
                case "confirm_password":
                  error = validatePassword(value!, confirm: true);
                  addError(error);
                case "phone":
                  error = validatePhone(value!);
                  addError(error);
                case "id":
                  error = validateIdNumber(value!);
                  addError(error);
                case "address":
                  error = validateAddress(value!);
                  addError(error);
                default:
                  error = 'Invalid type';
                  addError(error);
              }
              errors = errors.toSet().toList();
              errors.isNotEmpty ? onValidate(errors[0]) : null;
              errors.clear();
              return error;
            },
            obscureText: obs,
            keyboardType: getKeyboardInputType(type),
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontSize: 18,
            ),
            autovalidateMode: AutovalidateMode.disabled,
            decoration: InputDecoration(
              suffixIcon: setObs != null
                  ? GestureDetector(
                      onTap: () => setObs(),
                      child: Icon(obs ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black),
                    )
                  : const SizedBox(),
              contentPadding: const EdgeInsets.only(bottom: 10, top: 10),
              hintText: hint,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              errorStyle: const TextStyle(fontSize: 0),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget pickAddressFields(context, hint, ontap, {String? image, initial}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
    margin: const EdgeInsets.symmetric(vertical: 7),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(40.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image != null
            ? Image.asset("assets/icons/$image", height: 18)
            : const SizedBox(),
        SizedBox(width: image != null ? 13 : 0),
        Expanded(
          child: TextFormField(
            onTap: () => ontap(),
            // initialValue: initial,
            readOnly: true,
            controller: TextEditingController(text: initial),
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontSize: 18,
            ),
            autovalidateMode: AutovalidateMode.disabled,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 4),
              hintText: hint,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              errorStyle: const TextStyle(fontSize: 0),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}

void addError(val) {
  if (val != null) {
    errors.add(val);
  }
}

TextInputType getKeyboardInputType(type) {
  switch (type) {
    case "email":
      return TextInputType.emailAddress;
    case "phone":
      return TextInputType.phone;
    case "id":
      return TextInputType.number;
    default:
      return TextInputType.text;
  }
}

void showPickOptionsDialog(BuildContext context, cam, gal, {profile = true}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            // boxShadow: primaryShadow(context)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Visibility(
                visible: profile,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 3)),
                  leading: Icon(
                    Icons.photo,
                    color: Colors.black,
                    size: getWidth(context, 6),
                  ),
                  minLeadingWidth: getWidth(context, 1),
                  title: const Text(
                    'Gallary',
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () => gal(),
                ),
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: getWidth(context, 3)),
                leading: const Icon(
                  Icons.camera,
                  color: Colors.black,
                  // size: 18,
                ),
                minLeadingWidth: getWidth(context, 1),
                title: const Text(
                  'Camera',
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () => cam(),
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: getWidth(context, 3)),
                leading: Icon(
                  Icons.cancel,
                  color: Colors.black,
                  size: getWidth(context, 6),
                ),
                minLeadingWidth: getWidth(context, 1),
                title: const Text(
                  'Cancel',
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      });
}
