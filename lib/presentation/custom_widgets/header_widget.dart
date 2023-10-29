import 'package:flutter/material.dart';

class HeaderOfPage extends StatelessWidget {
  final String header;
  const HeaderOfPage({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.blue.shade500,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.blue.shade100,
                offset: const Offset(0, 6),
                blurRadius: 5,
                spreadRadius: 2)
          ]),
      child: Text(
        header,
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
