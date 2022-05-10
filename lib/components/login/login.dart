import 'package:flutter/material.dart';
import 'package:learnly/config/config.dart';
import 'package:provider/provider.dart';
import '../../data/data.dart' as Data;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return backgroundWrapper(
      SizedBox(
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
                  Data.runtime.login.switchLoginMode();
                })
          ],
        ),
        width: MediaQuery.of(context).size.width / 1.5,
      ),
    );
  }
}
