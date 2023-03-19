import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './login_or_signup.dart';
import './homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  autoLogin() async {
    SharedPreferences prefs = await SharedPrefmail: data.email
      return LoginOrSignup();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: autoLogin(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return LoginOrSignup();
          }
        },
      ),
    );
  }
}
