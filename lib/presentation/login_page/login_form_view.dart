import 'package:flutter/material.dart';
import 'package:neobis_auth_project/presentation/loading_page/loading_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(16.0),
        child: _getForm(),
      ),
    );
  }

  _submitEvent() async {
    buildLoading(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var answ = pref.getString(_usernameController.text) ?? '';
    await Future.delayed(const Duration(seconds: 2));

    if (answ.isNotEmpty) {
      if (answ == _passwordController.text) {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/');
      } else {
        print("passwor incorrect");
      }
    } else {
      print("no akk");
    }
  }

  Form _getForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Логин'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Пожалуйста, введите логин.';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Пароль'),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Пожалуйста, введите пароль.';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _submitEvent();
                }
              },
              child: const Text('Войти'),
            ),
          ),
        ],
      ),
    );
  }
}
