import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon userIcon;
  final int maxLines;
  final bool password;
  bool obscure;
  CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.userIcon,
      this.maxLines = 1,
      this.password = false,
      this.obscure = false});

  void passwording() {
    if (password == true) {
      obscure = true;
    } else {
      obscure = false;
    }
  }

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscure,
      decoration: InputDecoration(
        suffixIcon: widget.password
            ? IconButton(
                icon: Icon(
                    widget.obscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    widget.obscure = !widget.obscure;
                  });
                },
              )
            : null,
        hintText: widget.hintText,
        prefixIcon: widget.userIcon,
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your ${widget.hintText}';
        }
        if (widget.password == true && val.length < 8) {
          return 'Password must be at least 8 characters';
        }
        
        return null;
      },
      maxLines: widget.maxLines,
    );
  }
}
