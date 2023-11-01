import 'package:flutter/material.dart';
import 'package:neobis_auth_project/core/consts/assets_consts.dart';
import 'package:neobis_auth_project/core/consts/routes_consts.dart';
import 'package:neobis_auth_project/core/consts/styles_consts.dart';
import 'package:neobis_auth_project/data/memory.dart';
import 'package:neobis_auth_project/domain/model/user.dart';
import 'package:neobis_auth_project/presentation/custom_widgets/loading_view.dart';
import 'package:neobis_auth_project/presentation/custom_widgets/logo_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Memory {
  bool _wrongLogin = false;
  bool _wrongPass = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(16.0),
      child: _getForm(),
    );
  }

  Form _getForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const LogoSvg(assetsConsts: AssetsConsts.loginIcon),
            StylesConsts.sizedBox70,
            _loginFormField(),
            _passwordFormField(),
            StylesConsts.sizedBox20,
            _logInButton(),
            StylesConsts.sizedBox20,
            _signUpLink(),
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
        errorText: _wrongLogin ? 'Login is not correct' : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the login';
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
        errorText: _wrongPass ? 'Password is not correct' : null,
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the password';
        }
        return null;
      },
    );
  }

  SizedBox _logInButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _wrongLogin = false;
            _wrongPass = false;
          });
          if (_formKey.currentState!.validate()) {
            _loginEvent();
          }
        },
        child: const Text('Login'),
      ),
    );
  }

  Row _signUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Don’t have an Account? '),
        GestureDetector(
          onTap: () {
            _usernameController.clear();
            _passwordController.clear();
            Navigator.pushNamed(context, RoutesConsts.register);
          },
          child: const Text(
            'Sign up',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  _loginEvent() async {
    buildLoading(context);
    User user = User(
        login: _usernameController.text, password: _passwordController.text);

    //if user not existing in memory, then change state and show in form problem
    if (!await checkUser(user: user)) {
      setState(() {
        _wrongLogin = true;
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      return;
    }
    //if user puted wrong pass, then change state and show in form problem
    if (!await checkUserPassword(user: user)) {
      setState(() {
        _wrongPass = true;
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      return;
    }

    //if everything ok, then we go in another page
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, RoutesConsts.welcome);
  }
}
