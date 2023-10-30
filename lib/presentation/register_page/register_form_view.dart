import 'package:flutter/material.dart';
import 'package:neobis_auth_project/core/consts/assets_consts.dart';
import 'package:neobis_auth_project/data/memory.dart';
import 'package:neobis_auth_project/domain/model/user.dart';
import 'package:neobis_auth_project/presentation/custom_widgets/header_widget.dart';
import 'package:neobis_auth_project/presentation/custom_widgets/keyboard_aware.dart';
import 'package:neobis_auth_project/presentation/custom_widgets/loading_view.dart';
import 'package:neobis_auth_project/core/consts/styles_consts.dart';
import 'package:neobis_auth_project/presentation/custom_widgets/logo_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  bool _loginCheck = true;
  bool _checkPassword = true;
  bool _checkConfirmPassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(16.0),
      child: _getRegisterForm(context),
    );
  }

  Form _getRegisterForm(BuildContext contex) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const KeyboardAwareWidget(
              onOpen: true,
              child: HeaderOfPage(header: 'Sign Up'),
            ),
            const KeyboardAwareWidget(
              child: LogoSvg(assetsConsts: AssetsConsts.registerIcon),
            ),
            StylesConsts.sizedBox70,
            _loginFormField(),
            _passwordFormField(),
            _passwordConfirmField(),
            StylesConsts.sizedBox20,
            _registerButton(),
          ],
        ),
      ),
    );
  }

  SizedBox _registerButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _loginCheck = true;
          });
          _validationPassword();
          _validationConfirmPassword();
          if (_formKey.currentState!.validate() &&
              _checkPassword &&
              _checkConfirmPassword) {
            _registerEvent();
          }
        },
        style: StylesConsts().elevatedButtonStyle,
        child: const Text('Register'),
      ),
    );
  }

  TextFormField _loginFormField() {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
          labelText: 'Login',
          errorText: _loginCheck ? null : 'This login is already exist'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter login';
        }
        return null;
      },
    );
  }

  TextFormField _passwordFormField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText:
            _checkPassword ? null : 'Password should be at least 6 characters',
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
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
        labelText: "Confirm password",
        errorText: _checkConfirmPassword ? null : "Password shood be same",
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Confirm the password';
        }
        return null;
      },
    );
  }

  _validationPassword() {
    if (_passwordController.text.length <= 5) {
      setState(() {
        _checkPassword = false;
      });
    } else {
      setState(() {
        _checkPassword = true;
      });
    }
  }

  _validationConfirmPassword() {
    if (_passwordCheckController.text != _passwordController.text) {
      setState(() {
        _checkConfirmPassword = false;
      });
    } else {
      setState(() {
        _checkConfirmPassword = true;
      });
    }
  }

  _registerEvent() async {
    buildLoading(context);
    User user = User(
        login: _usernameController.text, password: _passwordController.text);

    if (!await Memory().checkUser(user: user)) {
      Memory().saveUser(user: user);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: avoid_print
      print('success');
    } else {
      setState(() {
        _loginCheck = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }
}
