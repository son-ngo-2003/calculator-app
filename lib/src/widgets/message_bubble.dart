import 'package:flutter/material.dart';

enum MessageType {
  error, warning, info, success
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message, required this.type});

  final MessageType type;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final icon =  type == MessageType.error ? Icons.error :
                  type == MessageType.warning ? Icons.warning :
                  type == MessageType.info ? Icons.info :
                  Icons.check_circle;
    
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 18, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: type == MessageType.error ? Colors.red : 
               type == MessageType.warning ? Colors.orange : 
               type == MessageType.info ? Colors.blue : 
               Colors.teal,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 10),
          Text(message, style: theme.textTheme.titleSmall?.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}