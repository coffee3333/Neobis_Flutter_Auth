import 'package:flutter/material.dart';
import 'package:neobis_auth_project/styles_consts.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

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
          child: const Text("Log In"),
          style: StylesConsts().elevatedButtonStyle,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text('Register'),
          style: StylesConsts().elevatedButtonStyle,
        ),
      ],
    );
  }
}
