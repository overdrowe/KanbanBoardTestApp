import 'package:flutter/material.dart';
import 'package:kanban_board/app_style/app_style.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?) validator;
  final String hintText;
  final bool isPassword;
  final GlobalKey textFieldKey;

  const CustomTextField({
    required this.onChanged,
    required this.validator,
    required this.hintText,
    this.isPassword = false,
    required this.textFieldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: textFieldKey,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(14),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppStyle().mainColor),
            borderRadius: BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white38),
            borderRadius: BorderRadius.circular(30.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white38),
            borderRadius: BorderRadius.circular(30.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white38),
            borderRadius: BorderRadius.circular(30.0),
          ),
          hintStyle: TextStyle(color: Colors.white38),
          fillColor: Colors.white,
          hintText: hintText,
        ),
        obscureText: isPassword,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
