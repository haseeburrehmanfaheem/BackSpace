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
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userImage),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 5),
        child:
            Text(username, style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
      trailing: Padding(
        padding: EdgeInsets.only(right: 15),
        child: Text(
          postTime,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
