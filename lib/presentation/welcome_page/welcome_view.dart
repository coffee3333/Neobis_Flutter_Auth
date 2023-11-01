import 'package:flutter/material.dart';
import 'package:neobis_auth_project/core/consts/assets_consts.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!'),
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Image.asset(
          AssetsConsts.runIcon,
          height: 400,
          width: 400,
        ),
      ),
    );
  }
}
