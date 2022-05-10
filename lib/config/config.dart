import 'package:flutter/material.dart';

class Config {
  static const String apiPath = 'https://forgetable.ru/api';
}

class Urls {
  static const String loginCheck = Config.apiPath + '/shared/checkLogin';
  static const String login = Config.apiPath + '/shared/login';
  static const String signup = Config.apiPath + '/shared/register';
}

class Consts {
  static const Padding padding = Padding(padding: EdgeInsets.all(14));
  static const Padding paddingHalf = Padding(padding: EdgeInsets.all(7));
}

Widget backgroundWrapper(child) {
  return Container(
    child: Center(
      child: child,
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.pinkAccent, Colors.redAccent],
        transform: GradientRotation(-50),
      ),
    ),
  );
}
