import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget{
  final String text;
  final String sender;
  final bool isMyMessage;
  MessageBubble({required this.sender, required this.text, this.isMyMessage= false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: isMyMessage? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender,style: TextStyle(color: Colors.grey),),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isMyMessage? Colors.blue : Colors.pinkAccent,
              borderRadius:  isMyMessage? BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0)) : BorderRadius.only(topLeft: Radius.circular(20.0),bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0)),
      
            ),
            child: Text(text,style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }

}