import 'package:flutter/material.dart';

import '../../../data/helper/helper.dart';

List<String> errors = [];

Widget inputField(context, hint, label, onsaved, type, onValidate) {
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
          validator: (value) {
            String? error;
            error = value!.isEmpty ? "$hint is required" : null;
            addError(error);
            errors = errors..toSet().toList();
            errors.isNotEmpty ? onValidate(errors[0]) : null;
            errors.clear();
            return error;
          },
          textCapitalization: TextCapitalization.sentences,
          minLines: desc ? 5 : 1,
          maxLines: desc ? 5 : 1,
          autovalidateMode: AutovalidateMode.disabled,
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

void addError(val) {
  if (val != null) {
    errors.add(val);
  }
}

TextInputType getKeyboard(type) {
  if (type == "number") {
    return TextInputType.number;
  } else {
    return TextInputType.text;
  }
}

Widget pickAddressFields(context, hint, label, ontap, {dynamic address}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Visibility(
        visible: label.toString().isNotEmpty,
        child: Text(
          " $label",
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
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextFormField(
          onTap: () => ontap(),
          readOnly: true,
          controller: TextEditingController(text: getAddress(address)),
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16 / MediaQuery.of(context).textScaleFactor),
          autovalidateMode: AutovalidateMode.disabled,
          decoration: decoration(hint),
        ),
      ),
    ],
  );
}

Widget datePicker(context, hint, label, ontap, {dynamic date}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Visibility(
        visible: label.toString().isNotEmpty,
        child: Text(
          " $label",
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
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextFormField(
            onTap: () => ontap(),
            readOnly: true,
            controller: TextEditingController(text: dateOnLy(date ?? "")),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16 / MediaQuery.of(context).textScaleFactor),
            autovalidateMode: AutovalidateMode.disabled,
            decoration: decoration(hint,
                suffixIcon:
                    const Icon(Icons.calendar_month, color: Colors.grey))),
      ),
    ],
  );
}

InputDecoration decoration(hint, {Widget suffixIcon = const SizedBox()}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(top: 10, bottom: 2),
    hintText: hint,
    hintStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    suffixIcon: suffixIcon,
    errorStyle: const TextStyle(fontSize: 0),
    border: InputBorder.none,
    errorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
  );
}

String getAddress(val) {
  if (val != null && val.address != null) {
    return val.address.nameAddress ?? "";
  }
  return "";
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
