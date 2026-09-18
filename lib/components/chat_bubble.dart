import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({super.key,
  required this.isCurrentUser,
  required this.message
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5) ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isCurrentUser? Colors.blue : Theme.of(context).colorScheme.primary
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(message.toString(),
        style: TextStyle(color: Colors.white,fontSize: 17),),
      ),
    );
  }
}