import 'package:flutter/material.dart';

class LoaderBar extends StatelessWidget {
  const LoaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          LinearProgressIndicator(),
        ],
      ),
    );
  }
}
