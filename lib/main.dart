import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './components/login/waiter.dart';
import './components/login/login.dart';
import './components/login/signup.dart';
import './data/data.dart' as Data;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Learnly',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(body: MyHomePage(title: 'Flutter Demo Home Page')));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          Data.Login login = Data.Login();
          Data.runtime.login = login;
          return login;
        }),
      ],
      child: DefaultTextStyle(
        key: Data.runtime.key,
        style: TextStyle(fontSize: 36, color: Colors.white),
        child: Consumer<Data.Login>(
          builder: (context, provider, child) => Navigator(
            pages: [
              if (!provider.initialised)
                MaterialPage(
                  key: ValueKey('loadingData'),
                  child: Waiter(),
                )
              else if (!provider.loggedIn && provider.loginMode == 'login')
                MaterialPage(
                  key: ValueKey('Login'),
                  child: Login(),
                )
              else if (!provider.loggedIn && provider.loginMode == 'signup')
                MaterialPage(
                  key: ValueKey('Signup'),
                  child: Signup(),
                )
              else
                MaterialPage(
                  key: ValueKey('Signup'),
                  child: Container(),
                )
            ],
            onPopPage: (route, result) => route.didPop(result),
          ),
        ),
      ),
    );
  }
}
