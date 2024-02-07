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

class InputFieldItem extends StatefulWidget {
  const InputFieldItem({
    Key? key,
    required this.hint,
    required this.label,
    required this.onsaved,
    required this.type,
    required this.onValidate,
  }) : super(key: key);
  final String hint;
  final String label;
  final Function onsaved;
  final String type;
  final Function onValidate;

  @override
  State<InputFieldItem> createState() => _InputFieldItemState();
}

class _InputFieldItemState extends State<InputFieldItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: TextFormField(
        onSaved: (val) => widget.onsaved(val),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 16 / MediaQuery.of(context).textScaleFactor,
        ),
        validator: (value) {
          String? error;
          error = value!.isEmpty ? "${widget.hint} is required" : null;
          addError(error);
          errors = errors..toSet().toList();
          errors.isNotEmpty ? widget.onValidate(errors[0]) : null;
          errors.clear();
          return error;
        },
        textCapitalization: TextCapitalization.sentences,
        minLines: widget.type == "description" ? 5 : 1,
        maxLines: widget.type == "description" ? 5 : 1,
        autovalidateMode: AutovalidateMode.disabled,
        keyboardType: getKeyboard(widget.type),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14 / MediaQuery.of(context).textScaleFactor,
          ),
          label: Text(
            " ${widget.label}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black54,
              fontSize: 15 / MediaQuery.of(context).textScaleFactor,
            ),
          ),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          errorStyle: const TextStyle(fontSize: 0),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
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
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, top: 10),
    child: TextFormField(
      onTap: () => ontap(),
      readOnly: true,
      controller: TextEditingController(text: getAddress(address)),
      style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 16 / MediaQuery.of(context).textScaleFactor),
      autovalidateMode: AutovalidateMode.disabled,
      decoration: decoration(hint, context, label),
    ),
  );
}

Widget datePicker(context, hint, label, ontap, {dynamic date}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, top: 10),
    child: TextFormField(
      onTap: () => ontap(),
      readOnly: true,
      controller: TextEditingController(text: dateOnLy(date ?? "")),
      style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 16 / MediaQuery.of(context).textScaleFactor),
      autovalidateMode: AutovalidateMode.disabled,
      decoration: decoration(
        hint,
        context,
        label,
        suffixIcon: const Icon(Icons.calendar_month, color: Colors.grey),
      ),
    ),
  );
}

Widget timePicker(context, hint, label, ontap, {dynamic time}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, top: 10),
    child: TextFormField(
      onTap: () => ontap(),
      readOnly: true,
      controller: TextEditingController(text: timeOnly(time ?? "")),
      style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 16 / MediaQuery.of(context).textScaleFactor),
      autovalidateMode: AutovalidateMode.disabled,
      decoration: decoration(
        hint,
        context,
        label,
        suffixIcon: const Icon(Icons.timelapse_outlined, color: Colors.grey),
      ),
    ),
  );
}

InputDecoration decoration(hint, context, label,
    {Widget suffixIcon = const SizedBox()}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14 / MediaQuery.of(context).textScaleFactor,
    ),
    label: Text(
      " $label",
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black54,
        fontSize: 15 / MediaQuery.of(context).textScaleFactor,
      ),
    ),
    floatingLabelAlignment: FloatingLabelAlignment.start,
    filled: true,
    fillColor: Colors.grey[300],
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    errorStyle: const TextStyle(fontSize: 0),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
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
