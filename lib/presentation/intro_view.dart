import 'package:flutter/material.dart';
import 'package:neobis_auth_project/styles_consts.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: _getButtons(context),
        ),
      ),
    );
  }

  Column _getButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          style: StylesConsts().elevatedButtonStyle,
          child: const Text("Log In"),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          style: StylesConsts().elevatedButtonStyle,
          child: const Text('Register'),
        ),
      ],
    );
  }
}
