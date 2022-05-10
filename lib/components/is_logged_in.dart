import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:learnly/config/config.dart';
import 'package:provider/provider.dart';
import '../data/data.dart' as Data;

Column loading() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: 'logo',
          child: Text('Learnly'),
        ),
        Padding(padding: EdgeInsets.all(20)),
        CircularProgressIndicator(
          color: Colors.white,
        ),
      ],
    );

Widget router() {
  return Container();
}

class RegisterForm extends StatefulWidget {
  final Function toggleSignUp;
  @override
  _RegisterFormState createState() => _RegisterFormState(toggleSignUp);
  RegisterForm(this.toggleSignUp);
}

class _RegisterFormState extends State<RegisterForm> {
  final Function toggleSignUp;
  _RegisterFormState(this.toggleSignUp);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Text('Learnly'),
            ),
            Consts.padding,
            TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: null,
                labelText: 'E-mail',
              ),
            ),
            Consts.paddingHalf,
            TextField(
              controller: _nicknameController,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: null,
                labelText: 'Nickname',
              ),
            ),
            Consts.paddingHalf,
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: null,
                focusColor: Colors.redAccent,
                labelText: 'Password',
              ),
            ),
            Consts.paddingHalf,
            TextField(
              controller: _passwordController2,
              obscureText: true,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: null,
                focusColor: Colors.redAccent,
                labelText: 'Repeat password',
              ),
            ),
            Consts.paddingHalf,
            Consumer<Data.Login>(
              builder: (context, provider, child) => ElevatedButton(
                onPressed: () {
                  final String password1 = _passwordController.text;
                  final String password2 = _passwordController2.text;
                  if (password1 != password2) {
                    SnackBar snackBar = SnackBar(
                        content: Text(
                      'Passwords don\'t match',
                      textAlign: TextAlign.center,
                    ));
                    ScaffoldMessenger.of(Data.runtime.key.currentContext!)
                        .showSnackBar(snackBar);
                    return;
                  }
                  provider.signUp(_emailController.text, password1,
                      _nicknameController.text);
                },
                child: Text('Sign up'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 40),
                    primary: Colors.black87),
              ),
            ),
            Consts.padding,
            GestureDetector(
              child: Text(
                'Already have an account?',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 20,
                    decoration: TextDecoration.underline),
              ),
              onTap: () => toggleSignUp(),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 1.5);
  }
}

class LoginForm extends StatefulWidget {
  final Function toggleSignUp;
  @override
  _LoginFormState createState() => _LoginFormState(toggleSignUp);
  LoginForm(this.toggleSignUp);
}

class _LoginFormState extends State<LoginForm> {
  final Function toggleSignUp;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  _LoginFormState(this.toggleSignUp);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Text('Learnly'),
            ),
            Consts.padding,
            TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: null,
                labelText: 'E-mail',
              ),
            ),
            Consts.paddingHalf,
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: null,
                focusColor: Colors.redAccent,
                labelText: 'Password',
              ),
            ),
            Consts.paddingHalf,
            Consumer<Data.Login>(
              builder: (context, provider, child) => ElevatedButton(
                onPressed: () {
                  provider.signIn(
                      _emailController.text, _passwordController.text);
                },
                child: Text('Sign in'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 40),
                    primary: Colors.black87),
              ),
            ),
            Consts.padding,
            GestureDetector(
                child: Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 20,
                      decoration: TextDecoration.underline),
                ),
                onTap: () {
                  toggleSignUp();
                })
          ],
        ),
        width: MediaQuery.of(context).size.width / 1.5);
  }
}

class IsLoggedIn extends StatefulWidget {
  @override
  _IsLoggedInState createState() => _IsLoggedInState();
}

class _IsLoggedInState extends State<IsLoggedIn> {
  bool isSigningUp = false;

  void toggleSignUp() => setState(() {
        isSigningUp = !isSigningUp;
      });

  Widget build(BuildContext context) {
    return Consumer<Data.Login>(
      builder: (context, value, child) => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.redAccent],
                transform: GradientRotation(-50))),
        child: Center(
            child: Container(
                child: !value.initialised
                    ? loading()
                    : !value.loggedIn
                        ? isSigningUp
                            ? RegisterForm(toggleSignUp)
                            : LoginForm(toggleSignUp)
                        : router())),
      ),
    );
  }
}
