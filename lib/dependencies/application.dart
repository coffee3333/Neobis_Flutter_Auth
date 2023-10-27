import 'package:flutter/material.dart';
import 'package:neobis_auth_project/presentation/login_page/login_view.dart';
import 'package:neobis_auth_project/presentation/main_view.dart';
import 'package:neobis_auth_project/presentation/register_page/register_view.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const MainView(),
        '/login': (context) => const LogInPage(),
        '/register': (context) => const RegisterPage()
      },
      initialRoute: "/",
    );
  }
}