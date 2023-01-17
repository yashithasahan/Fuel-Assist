import 'package:flutter/material.dart';
import 'package:speed_shop/features/account/widgets/app_button.dart';

class AppButtons extends StatefulWidget {
  const AppButtons({super.key});

  @override
  State<AppButtons> createState() => _AppButtonsState();
}

class _AppButtonsState extends State<AppButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppButton(
              name: "Sign Out",
              onTap: (() {}),
            ),
            AppButton(
              name: "Sign Out",
              onTap: (() {}),
            )
          ],
        )
      ],
    );
  }
}
