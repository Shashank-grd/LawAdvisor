import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isImage;
  final String? imageUrl;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.isImage = false,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) CircleAvatar(child: Icon(Icons.android, color: Colors.white)),
          SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue[300] : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: isImage && imageUrl != null
                  ? kIsWeb
                  ? Image.network(
                imageUrl!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
                  : Image.file(
                File(imageUrl!),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
                  : Text(
                text,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          if (isUser) CircleAvatar(child: Icon(Icons.person, color: Colors.white)),
        ],
      ),
    );
  }
}