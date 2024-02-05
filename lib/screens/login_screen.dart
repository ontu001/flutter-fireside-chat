// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/constants.dart';
import 'package:flutter_firebase_chat/screens/chat_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/RoundedButton.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
              decoration: kTextFiledDecoretaion.copyWith(
                  hintText: 'Enter your email'
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFiledDecoretaion.copyWith(
                hintText: 'Enter your password'
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                color: Colors.lightBlueAccent,
                onpressed: () async{
                     try {
                    final newUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if (newUser != null) {
                      Fluttertoast.showToast(
                          msg: "Log In Successful",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.blueGrey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                          Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                title: "Log In"),
          ],
        ),
      ),
    );
  }
}

