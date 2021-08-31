import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';

class EditTextUtils {
  TextFormField getCustomEditTextArea(
      {String labelValue = "",
      String hintValue = "",
      String? Function(String?)? validator,
      IconData? icon,
      bool? validation,
      TextEditingController? controller,
      TextInputType keyboardType = TextInputType.text,
      String? validationErrorMsg,}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.white),
        filled: true,
        labelText: labelValue,
        labelStyle: TextStyle(color: Color(kWhite)),
        fillColor: Color(kWhite).withOpacity(0.4),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide:
                BorderSide(color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide:
                BorderSide(color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide:
                BorderSide(color: Colors.transparent)),
        hintText: hintValue,
        
        hintStyle: TextStyle(
            color: Color(kWhite), fontSize: kNormalFont),
      ),
    validator: validator,
    );
  }
}
