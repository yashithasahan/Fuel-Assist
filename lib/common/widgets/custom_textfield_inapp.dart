import 'package:flutter/material.dart';

class CustomTextFieldIn extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon userIcon;
  final int maxLines;
  const CustomTextFieldIn(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.userIcon,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black12,
        )),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
        )),
        prefixIcon: userIcon,
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
