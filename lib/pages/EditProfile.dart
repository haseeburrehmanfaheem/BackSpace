// ignore_for_file: deprecated_member_use, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, false),
        ),
        title:
            const Text('Edit Profile', style: TextStyle(fontFamily: "Poppins")),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(child: MyCustomForm()),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference cl =
      FirebaseFirestore.instance.collection('UserData');

  @override
  Widget build(BuildContext context) {
    String? s = "backspace";
    if (user != null) {
      s = user?.email;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FutureBuilder<String>(
          future: getUsername(s),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String y;
              return Text(
                snapshot.data ?? "hello",
                //cursorColor: Theme.of(context).cursorColor,
                // maxLength: 20,
              );
            } else {
              return TextFormField(
                initialValue: s,
                //cursorColor: Theme.of(context).cursorColor,
                // maxLength: 20,
                decoration: InputDecoration(
                  fillColor: Color(0xfff9f9fa),
                  filled: true,
                  //icon: Icon(Icons.favorite),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff000000)),
                  ),
                ),
              );
            }
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            "Profile",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        ),
        OutlineButton(
          child: const Text(
            "Upload",
            style: TextStyle(fontSize: 20.0),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            "Your Name",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: FutureBuilder<String>(
            future: getUsername(s),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TextFormField(
                  initialValue: snapshot.data ?? "hello",
                  //cursorColor: Theme.of(context).cursorColor,
                  // maxLength: 20,
                  decoration: InputDecoration(
                    fillColor: Color(0xfff9f9fa),
                    filled: true,
                    //icon: Icon(Icons.favorite),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff000000)),
                    ),
                  ),
                );
              } else {
                return TextFormField(
                  initialValue: s,
                  //cursorColor: Theme.of(context).cursorColor,
                  // maxLength: 20,
                  decoration: InputDecoration(
                    fillColor: Color(0xfff9f9fa),
                    filled: true,
                    //icon: Icon(Icons.favorite),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff000000)),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            "About",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: TextField(
            //cursorColor: Theme.of(context).cursorColor,
            // maxLength: 20,
            decoration: InputDecoration(
              fillColor: Color(0xfff9f9fa),
              filled: true,
              //icon: Icon(Icons.favorite),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff000000)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future<String> getUsername(email) async {
  var ref = await FirebaseFirestore.instance
      .collection("UserData")
      .where("email", isEqualTo: email)
      .get();
  // final ref = FirebaseDatabase.instance.reference();
  // if(ref)
  // print(ref.docs[0]["username"]);
  var s = ref.docs[0]["username"];
  return s ?? " ";
}
