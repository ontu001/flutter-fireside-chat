// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/screens/chat_screen.dart';
import 'package:flutter_firebase_chat/screens/login_screen.dart';
import 'package:flutter_firebase_chat/screens/registration_screen.dart';
import 'screens/welcome_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context)=>WelcomeScreen(),
        ChatScreen.id : (context)=>ChatScreen(),
        LoginScreen.id : (context)=>LoginScreen(),
        RegistrationScreen.id : (context)=>RegistrationScreen(),

      },
    );
  }
}
