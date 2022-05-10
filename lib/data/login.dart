import 'package:flutter/material.dart';
import 'package:learnly/data/storage.dart';
import 'package:learnly/utils.dart';
import '../config/config.dart';
import './user.dart';
import './data.dart' as Data;

class Login extends ChangeNotifier {
  static const String storageName = 'login';
  bool loggedIn = false;
  bool initialised = false;
  User user = User();
  String loginMode = 'login';

  void switchLoginMode() {
    loginMode = loginMode == 'login' ? 'signup' : 'login';
    notifyListeners();
  }

  // Check storage and then make request to check if client is logged in
  void fetchData() async {
    await initializeFromJson();
    Map? response = await httpPost(Urls.loginCheck, {});
    if (response != null) {
      initialised = true;
      loggedIn = response['error'] == 0 ? true : false;
      notifyListeners();
    }
  }

  // Function for getting saved data (primarily session) from json and putting it into user
  initializeFromJson() async {
    // Storage.set(storageName, {});
    Map loginData = await Storage.get(storageName);
    String userData = loginData['user'] ?? '{}';
    user = User.fromJson(userData);
  }

  Map toMap() {
    return {
      'loggedIn': loggedIn,
      'user': user.toJson(),
    };
  }

  Login() {
    fetchData();
  }

  Future<bool?> signIn(email, password) async {
    Map? response =
        await httpPost(Urls.login, {'email': email, 'password': password});
    if (response == null) return false;
    user.session = response['session'];
    user.email = response['email'];
    user.nickname = response['nickname'];
    loggedIn = true;
    Storage.set(storageName, toMap());
    notifyListeners();
  }

  Future<bool?> signUp(email, password, nickname) async {
    Map? response = await httpPost(Urls.signup,
        {'email': email, 'password': password, 'nickname': nickname});
    SnackBar snackBar = SnackBar(
        content: Text(
      'You have successfully signed up.',
      textAlign: TextAlign.center,
    ));
    ScaffoldMessenger.of(Data.runtime.key.currentContext!)
        .showSnackBar(snackBar);
    switchLoginMode();
  }
}
