import 'package:flutter/material.dart';
import 'package:learnly/config/config.dart';
import 'package:provider/provider.dart';
import '../../data/data.dart' as Data;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();
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
                onTap: () => Data.runtime.login.switchLoginMode(),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width / 1.5),
    );
  }
}
