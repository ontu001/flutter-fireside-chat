// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/widgets/message_bubble.dart';

import '../constants.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String textMessage = '';
  late User loggedInuser;

  void getNewUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInuser = user;
        print(loggedInuser.email);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getUserMessage() async {
    final message = await _firestore.collection('messages').get();
    for (var messages in message.docs) {
      print(messages.data());
    }
  }

  void getStreamMessage() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var messages in snapshot.docs) {
        print(messages.data());
      }
    }
  }

  @override
  void initState() {
    getNewUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                getStreamMessage();
                _auth.signOut();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data!.docs.reversed;

                    List<MessageBubble> messageWidgets = [];
                    for (var message in messages) {
                      final messageText = message['text'];
                      final messageSender = message['sender'];
                      final currentUser = loggedInuser.email;

                      messageWidgets.add(
                        MessageBubble(sender: messageSender, text: messageText,
                        isMyMessage: currentUser == messageSender,
                        ),
                      );
                    }

                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ListView(
                          children: messageWidgets,
                          reverse: true,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      width: 200,
                      height: 50,
                      child: Center(
                          child: CircularProgressIndicator(
                              backgroundColor: Colors.lightBlueAccent)),
                    );
                  }
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {
                        textMessage = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    style:
                        TextButton.styleFrom(textStyle: kSendButtonTextStyle),
                    onPressed: () {
                      textController.clear();
                      _firestore.collection('messages').add({
                        'sender': loggedInuser.email,
                        'text': textMessage,
                      });
                    },
                    child: const Text(
                      'Send',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
