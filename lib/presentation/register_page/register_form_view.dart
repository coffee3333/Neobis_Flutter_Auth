import 'package:flutter/material.dart';
import 'package:neobis_auth_project/core/consts/assets_consts.dart';
import 'package:neobis_auth_project/data/memory.dart';
import 'package:neobis_auth_project/domain/model/user.dart';
import 'package:neobis_auth_project/presentation/custom_widgets/loading_view.dart';
import 'package:neobis_auth_project/core/consts/styles_consts.dart';
import 'package:neobis_auth_project/presentation/custom_widgets/logo_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> with Memory {
  bool _loginCheck = true; //For checking existing logins in memory
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
            const LogoSvg(assetsConsts: AssetsConsts.registerIcon),
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
      decoration: const InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter password';
        } else if (_passwordController.text.length <= 5) {
          return 'Password should be at least 6 characters';
        }
        return null;
      },
    );
  }

  TextFormField _passwordConfirmField() {
    return TextFormField(
      controller: _passwordCheckController,
      decoration: const InputDecoration(
        labelText: "Confirm password",
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Confirm the password';
        } else if (_passwordCheckController.text != _passwordController.text) {
          return "Password shood be same";
        }
        return null;
      },
    );
  }

  SizedBox _registerButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _loginCheck =
                true; // on registration event we are clearing old state
          });

          if (_formKey.currentState!.validate()) {
            _registerEvent();
          }
        },
        style: StylesConsts().elevatedButtonStyle,
        child: const Text('Register'),
      ),
    );
  }

  _registerEvent() async {
    buildLoading(context); // loading widget
    final user = User(
        login: _usernameController.text, password: _passwordController.text);

    //checking for existing users in memory
    if (await checkUser(user: user)) {
      setState(() {
        _loginCheck =
            false; // if exist then we are changing state to show in field
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // clearing loading widget
      return;
    }

    saveUser(user: user); // if not existing in memory then we are saving
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); // clearing loading widget
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); // Going back
    // ignore: avoid_print
    print('success');
  }
}
