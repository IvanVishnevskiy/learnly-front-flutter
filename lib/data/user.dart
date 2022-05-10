import 'dart:convert';

class User {
  String nickname = '';
  String email = '';
  String dictionaries = '';
  String preferences = '';
  String session = '';

  String toJson() {
    return jsonEncode(
        {'nickname': nickname, 'email': email, 'session': session});
  }

  User();

  factory User.fromJson(json) {
    Map jsonParsed = jsonDecode(json);
    User user = User();
    user.nickname = jsonParsed['nickname'] ?? '';
    user.email = jsonParsed['email'] ?? '';
    user.dictionaries = jsonParsed['dictionaries'] ?? '';
    user.session = jsonParsed['session'] ?? '';
    return user;
  }
}
