import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      child: const Text("Welcome"),
    );
  }
}
