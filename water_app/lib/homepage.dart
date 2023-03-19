import './login_or_signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

username() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String mail = prefs.getString('mail');

  return Text("Mail is: $mail");
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    logOut() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Set loggedIn back to false
      prefs.setBool('loggedin', false);
      // Delete mail user.
      prefs.remove('mail');

      // Navigate to homepage.
      return Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => LoginOrSignup(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 200),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("You have succesfully logged in!"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: FutureBuilder(
              future: username(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data;
                } else {
                  return Text("Mail is: undefined");
                }
              },
            ),
          ),
          Center(
            child: MaterialButton(
              child: Text("Logout"),
              onPressed: () => logOut(),
            ),
          ),
        ],
      ),
    );
  }
}
