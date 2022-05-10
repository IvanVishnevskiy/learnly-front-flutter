import 'dart:convert';
import 'package:flutter/material.dart';

import './data/data.dart' as Data;

import 'package:http/http.dart' as http;

Future<Map?> httpGet(url) async {
  try {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return null;
    Map<String, dynamic> parsedResponse = jsonDecode(response.body);
    if (parsedResponse['error'] != null) {
      SnackBar snackBar =
          SnackBar(content: Text('Error: ${parsedResponse['errrorname']}'));
      ScaffoldMessenger.of(Data.runtime.key.currentContext!)
          .showSnackBar(snackBar);
      return null;
    }
    return parsedResponse;
  } catch (e) {
    return null;
  }
}

Future<Map?> httpPost(String url, Map body) async {
  String? session = Data.runtime.login.user.session;
  if (session.isNotEmpty) {
    body = {...body, '_session': session};
  }
  try {
    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
    );
    if (response.statusCode != 200) return null;
    Map<String, dynamic> parsedResponse = jsonDecode(response.body);
    int error = parsedResponse['error'] ?? 0;
    if (error != 0 && error != 100) {
      SnackBar snackBar = SnackBar(
          content: Text(
        parsedResponse['errorname'],
        textAlign: TextAlign.center,
      ));
      ScaffoldMessenger.of(Data.runtime.key.currentContext!)
          .showSnackBar(snackBar);
      return null;
    }
    return parsedResponse;
  } catch (e) {
    return null;
  }
}
