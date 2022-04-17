import 'package:backspace/pages/ViewProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lit_relative_date_time/controller/relative_date_format.dart';
import 'package:lit_relative_date_time/model/relative_date_time.dart';

class UserIconName extends StatelessWidget {
  final String userImage;
  final Timestamp postTime;
  final String username;
  final String? userabout;
  final String? delete;
  final user = FirebaseAuth.instance.currentUser;

  // ignore: use_key_in_widget_constructors
  UserIconName(
      {required this.userImage,
      required this.username,
      required this.postTime,
      this.userabout,
      this.delete});
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
      // !delete ? : 
      trailing: delete == null ? trail(context, postTime) : (delete == user!.email) ? trail2(context, postTime) : trail(context, postTime) 
       
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


Widget trail(context, postTime) {
  return Wrap(
        children: 
        [ 
          Padding(
          padding: EdgeInsets.only(right: 15,),
          child: Text(
            RelativeDateFormat(
                Localizations.localeOf(context),
              ).format(
                RelativeDateTime(
                  dateTime: DateTime.now(),
                  other: DateTime.parse(
                    postTime.toDate().toString(),
                  ),
                ),
              ),
              style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        ]
      );
}


Widget trail2(context, postTime) {
  return Wrap(
        children: 
        [ 
          Padding(
          padding: EdgeInsets.only(right: 15, top: 10),
          child: Text(
            RelativeDateFormat(
                Localizations.localeOf(context),
              ).format(
                RelativeDateTime(
                  dateTime: DateTime.now(),
                  other: DateTime.parse(
                    postTime.toDate().toString(),
                  ),
                ),
              ),
              style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        // true ? 
        IconButton(
          onPressed: () {

          }, 
          icon: Icon(Icons.delete_outlined)
          ) 
          // : Text("")
        ]
      );
}