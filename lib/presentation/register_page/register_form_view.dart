import 'package:flutter/material.dart';
import 'package:neobis_auth_project/presentation/loading_page/loading_view.dart';
import 'package:neobis_auth_project/styles_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  bool _checkPassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: _getRegisterForm(context),
    );
  }

  Form _getRegisterForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _loginFormField(),
          _passwordFormField(),
          _passwordConfirmField(),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() && _checkPassword) {
                  _registerEvent();
                }
              },
              style: StylesConsts().elevatedButtonStyle,
              child: const Text('Register'),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField _loginFormField() {
    return TextFormField(
      controller: _usernameController,
      decoration: const InputDecoration(labelText: 'Login'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter login';
        }
        return null;
      },
    );
  }

  TextFormField _passwordFormField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter password';
        }
        return null;
      },
    );
  }

  TextFormField _passwordConfirmField() {
    return TextFormField(
      controller: _passwordCheckController,
      decoration: InputDecoration(
          labelText:
              _checkPassword ? "Confirm password" : "Password shood be same",
          labelStyle:
              TextStyle(color: _checkPassword ? Colors.grey : Colors.red)),
      obscureText: true,
      onChanged: _validationConfirmPass,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Confirm the password';
        }
        return null;
      },
    );
  }

  void _validationConfirmPass(text) {
    if (text.isNotEmpty) {
      if (text != _passwordController.text) {
        setState(
          () {
            _checkPassword = false;
          },
        );
      } else {
        setState(() {
          _checkPassword = true;
        });
      }
    } else {
      setState(() {
        _checkPassword = true;
      });
    }
  }

  _saveUser({required String login, required String pass}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(login, pass);
    await Future.delayed(const Duration(seconds: 2));
  }

  _registerEvent() async {
    buildLoading(context);
    await _saveUser(
        login: _usernameController.text, pass: _passwordController.text);
    _formKey.currentState?.reset();
    _usernameController.clear();
    _passwordController.clear();
    _passwordCheckController.clear();
    Navigator.of(context).pop();
    Navigator.pushNamed(context, '/login');
  }
}
