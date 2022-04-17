import 'package:flutter/material.dart';

List<Widget> checkImageAndText(postImage, postText, senderOrReceiver) {
  final List<Widget> chatItems = [];
  if (postImage != "") {
    chatItems.add(ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        postImage,
        fit: BoxFit.fill,
      ),
    ));
    chatItems.add(const Padding(padding: EdgeInsets.all(3)));
  }
  if (postText != "") {
    chatItems.add(
      Text(
        postText,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: senderOrReceiver == "receiver" ? Colors.white : Colors.black,
        ),
      ),
    );
  }
  return chatItems;
}
