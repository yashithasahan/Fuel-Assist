import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const AppButton({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0),
        borderRadius: BorderRadius.circular(90),
        color: Colors.white,
      ),
      child: OutlinedButton(
          onPressed: onTap,
          child: Text(
            name,
            style: const TextStyle(color: Colors.black),
          )),
    );
  }
}
