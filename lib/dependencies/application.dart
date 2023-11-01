import 'package:flutter/material.dart';
import 'package:neobis_auth_project/core/consts/routes_consts.dart';
import 'package:neobis_auth_project/presentation/login_page/login_view.dart';
import 'package:neobis_auth_project/presentation/welcome_page/welcome_view.dart';
import 'package:neobis_auth_project/presentation/register_page/register_view.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RoutesConsts.welcome: (context) => const WelcomeView(),
        RoutesConsts.login: (context) => const LogInPage(),
        RoutesConsts.register: (context) => const RegisterPage(),
      },
      initialRoute: RoutesConsts.login,
    );
  }
}
