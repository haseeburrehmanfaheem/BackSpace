// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'Notification.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: const Text('Chats', style: TextStyle()),
          actions: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.search, color: Colors.black)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  icon: Icon(Icons.notifications_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Noti()),
                    );
                  },
                ))
          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            Sender(
                postText:
                    'Please try and give some feedback on it!ttttttttttttttttttttttttttttttttttt',
                userImage: 'assets/images/bill-gates.jpg'),
            Reciever(
                postText:
                    'Sure gufufyutyiyu8u8sdxfcgvhjklretyuioplkjhgvcxcvbnm,./,mnbv vbnm,.guyuioi djwwdhwdhwkhwdwdjhw'),
          ],
        ));
  }
}

class Sender extends StatelessWidget {
  final String? userImage;
  final String postText;
  // ignore: use_key_in_widget_constructors
  const Sender({this.userImage, required this.postText});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10, left: 5),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(userImage!),
            ),
            BubbleSpecialThree(
              text: postText,
              color: Color(0xFFE8E8EE),
              tail: false,
              isSender: false,
            ),
          ],
        ));
  }
}

class Reciever extends StatelessWidget {
  final String postText;
  // ignore: use_key_in_widget_constructors
  const Reciever({required this.postText});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: BubbleSpecialThree(
          text: postText,
          color: Color(0xFF323232),
          tail: false,
          textStyle: TextStyle(color: Colors.white, fontSize: 16),
        ));
  }
}
