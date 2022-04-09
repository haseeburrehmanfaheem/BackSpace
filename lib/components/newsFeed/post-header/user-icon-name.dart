import 'package:flutter/material.dart';

class UserIconName extends StatelessWidget {
  final String userImage;
  final String postTime;
  final String username;
  // ignore: use_key_in_widget_constructors
  const UserIconName(
      {required this.userImage,
      required this.username,
      required this.postTime});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(userImage)),
      title:
          Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(postTime),
    );
  }
}
