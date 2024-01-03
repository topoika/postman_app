import 'package:flutter/material.dart';

Widget inputField(
  context,
  hint,
  label,
  onsaved,
  type,
) {
  bool desc = type == "description";
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Visibility(
        visible: label.toString().isNotEmpty,
        child: Text(
          " " + label,
          textScaleFactor: 1,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 10, top: 5),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextFormField(
          onSaved: (val) => onsaved(val),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 16 / MediaQuery.of(context).textScaleFactor,
          ),
          textCapitalization: TextCapitalization.sentences,
          minLines: desc ? 5 : 1,
          maxLines: desc ? 5 : 1,
          keyboardType: getKeyboard(type),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 10, top: 6),
            hintText: hint,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14 / MediaQuery.of(context).textScaleFactor,
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
  );
}

TextInputType getKeyboard(type) {
  if (type == "number") {
    return TextInputType.number;
  } else {
    return TextInputType.text;
  }
}

Widget pickAddressFields(context, hint, label, ontap, {dynamic address}) {
  print(address);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Visibility(
        visible: label.toString().isNotEmpty,
        child: Text(
          " " + label,
          textScaleFactor: 1,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: TextFormField(
          onTap: () => ontap(),
          readOnly: true,
          controller: TextEditingController(
              text: address != null ? address.address.address : ""),
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
  );
}

Widget mainHeading(context, txt) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10).copyWith(bottom: 3),
    child: Text(
      txt,
      textScaleFactor: 1,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontSize: 17,
      ),
    ),
  );
}
