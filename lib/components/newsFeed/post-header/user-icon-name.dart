import 'package:backspace/pages/ViewProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserIconName extends StatelessWidget {
  final String userImage;
  final String postTime;
  final String username;
  final String? userabout;
  // ignore: use_key_in_widget_constructors
  const UserIconName(
      {required this.userImage,
      required this.username,
      required this.postTime,
      this.userabout});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
      GestureDetector(
        onTap: () {
          if(userabout == null){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ViewProfile(username: username, userimageURL: userImage,)));
          }
          else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ViewProfile(username: username, userimageURL: userImage, userAbout: userabout)));
          }
          // Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => ViewProfile(username: username, userimageURL: userImage, userAbout: userabout)));
        },
        child: CircleAvatar(
        backgroundImage: NetworkImage(userImage),
      ),
      ),
      // CircleAvatar(
      //   backgroundImage:
      //   NetworkImage(userImage),
      // ),
      title: Padding(
        padding: EdgeInsets.only(left: 0),
        child: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ViewProfile(username: username, userimageURL: userImage, userAbout: userabout)));
        }, 
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(username, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black, ))), )
        
            // Text(username, style: const TextStyle(fontWeight: FontWeight.w500)),
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

Future<QueryDocumentSnapshot<Map<String, dynamic>>> getUserAbout(email) async {
  var ref = await FirebaseFirestore.instance
      .collection("UserData")
      .where("email", isEqualTo: email)
      .get();

  var s = ref.docs[0];
  return s;
}
