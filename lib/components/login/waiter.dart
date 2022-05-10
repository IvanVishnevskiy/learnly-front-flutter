import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/data.dart' as Data;

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

class Waiter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data.Login>(
      builder: (context, value, child) => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.redAccent],
                transform: GradientRotation(-50))),
        child: Center(child: Container(child: loading())),
      ),
    );
  }
}
