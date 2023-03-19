import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

login(context, _mail, _pwd) async {
  String auth = "chatappauthkey231r4";
  if (_mail.isNotEmpty && _pwd.isNotEmpty) {
    IOWebSocketChannel channel;
    try {
      // Create connection.
      channel = IOWebSocketChannel.connect('ws://localhost:3000/login$_mail');
    } catch (e) {
      print("Error on connecting to websocket: " + e);
    }
    // Data that will be sended to Node.js
    String signUpData =
        "{'auth':'$auth','cmd':'login','email':'$_mail','hash':'$_pwd'}";
    // Send data to Node.js
    channel.sink.add(signUpData);
    // listen for data from the server
    channel.stream.listen((event) async {
      event = event.replaceAll(RegExp("'"), '"');
      var loginData = json.decode(event);
      // Check if the status is succesfull
      if (loginData["status"] == 'succes') {
        // Close connection.
        channel.sink.close();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('loggedin', true);
        prefs.setString('mail', _mail);
        // Return user to login if succesfull
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        channel.sink.close();
        print("Error signing signing up");
      }
    });
  } else {
    print("Password are not equal");
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _mail;
    String _pwd;

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Mail or password..',
              ),
              onChanged: (e) => _mail = e,
            ),
          ),
          Center(
            child: TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Password..',
              ),
              onChanged: (e) => _pwd = e,
            ),
          ),
          Center(
            child: MaterialButton(
              child: Text("Login"),
              onPressed: login(context, _mail, _pwd),
            ),
          ),
        ],
      ),
    );
  }
}
