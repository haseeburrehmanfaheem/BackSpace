// ignore_for_file: deprecated_member_use, prefer_const_constructors
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

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

Future handleChoosefromgallery() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File imageTemp = File(image.path);

    final user = FirebaseAuth.instance.currentUser;
    var ref = await FirebaseFirestore.instance
        .collection("UserData")
        .where("email", isEqualTo: user?.email)
        .get();
    if (user != null) {
      String? e = user.email;

      final ref2 = FirebaseStorage.instance
          .ref()
          .child("UserImages")
          .child(e! + "_image.jpg");

      await ref2.putFile(imageTemp);
      String URL = await ref2.getDownloadURL();

      ref.docs[0].reference.update({'imageURL': URL});
      print("HOGIAAAA");
    }
    // setState(() => this.image = imageTemp);
  } on PlatformException catch (e) {
    print('Failed to pick image: $e');
  }
}

Widget buildEditIcon() => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: Colors.black.withOpacity(0.5),
        all: 8,
        child: IconButton(
          icon: Icon(Icons.camera_alt_rounded),
          onPressed: handleChoosefromgallery,
          color: Colors.white,
          // size: 20,
        ),
      ),
    );

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );

Widget buildImage(s) {
  return ClipOval(
    child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: NetworkImage(s),
        fit: BoxFit.cover,
        width: 128,
        height: 128,
        child: InkWell(),
      ),
    ),
  );
}

// "https://firebasestorage.googleapis.com/v0/b/backspace-current.appspot.com/o/UserImages%2Fdefault.png?alt=media&token=dc5d36d7-0cb9-4b94-a36d-2f58bf776be5"
class MyCustomForm extends StatelessWidget {
  final TextEditingController NameController = TextEditingController();

  final TextEditingController AboutController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference cl =
      FirebaseFirestore.instance.collection('UserData');

  @override
  Widget build(BuildContext context) {
    // UpdateNameAbout("haseeb ur rehman", "new about");
    String? s = "backspace";
    if (user != null) {
      s = user?.email;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: FutureBuilder<QueryDocumentSnapshot<Map<String, dynamic>>>(
            future: getUsername(s),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String url = snapshot.data?.data()["imageURL"];
                return Stack(
                  // initialValue: txt.data,
                  children: [
                    buildImage(url),
                    Positioned(bottom: 0, right: 0.5, child: buildEditIcon()),
                  ],
                );
              } else {
                return Text("Loading...");
              }
            },
          ),

          //  Stack(
          //   children: [
          //     buildImage("hehe"),
          //     Positioned(bottom: 0, right: 0.5, child: buildEditIcon()),
          //   ],
          // ),
          //
          // ClipOval(
          //   child: Material(
          //     color: Colors.transparent,
          //     child: Ink.image(
          //       image: NetworkImage(
          //           "https://firebasestorage.googleapis.com/v0/b/backspace-current.appspot.com/o/UserImages%2Fdefault.png?alt=media&token=dc5d36d7-0cb9-4b94-a36d-2f58bf776be5"),
          //       fit: BoxFit.cover,
          //       width: 128,
          //       height: 128,
          //       child: InkWell(),
          //     ),
          //   ),
          // )

          // MaterialButton(
          //   child: const Text(
          //     "Upload",
          //     style: TextStyle(fontSize: 10.0),
          //   ),
          //   onPressed: () {},
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          // ),
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
          child: FutureBuilder<QueryDocumentSnapshot<Map<String, dynamic>>>(
            future: getUsername(s),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Text txt = Text(
                  snapshot.data?.data()["username"],
                );
                return TextFormField(
                  // initialValue: txt.data,
                  controller: NameController,
                  decoration: InputDecoration(
                    labelText: txt.data,
                    fillColor: Color(0xfff9f9fa),
                    filled: true,
                    //icon: Icon(Icons.favorite),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff000000)),
                    ),
                  ),
                );
              } else {
                return Text("Loading...");
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: FutureBuilder<QueryDocumentSnapshot<Map<String, dynamic>>>(
            future: getUsername(s),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Text txt = Text(
                  snapshot.data?.data()["about"],
                );
                return TextFormField(
                  // initialValue: txt.data,
                  controller: AboutController,
                  decoration: InputDecoration(
                    labelText: txt.data,
                    fillColor: Color(0xfff9f9fa),
                    filled: true,
                    //icon: Icon(Icons.favorite),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff000000)),
                    ),
                  ),
                );
              } else {
                return Text("Loading...");
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, top: 80, right: 24),
          child: MaterialButton(
            minWidth: double.infinity,
            height: 60,
            onPressed: () async {
              if (NameController != null && AboutController != null) {
                await UpdateNameAbout(
                    NameController.text, AboutController.text);
              }
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => EditProfile()));

              // print("hello world");
              // String val = "";
              // if (formkey1.currentState!.validate() &&
              //     formkey2.currentState!.validate() &&
              //     formkey3.currentState!.validate() &&
              //     formkey4.currentState!.validate()) {
              //   // Future<dynamic>
              //   // String val =
              //   signUp(
              //       emailController.text,
              //       password1Controller.text,
              //       nameController.text,
              //       context);
              // }
            },
            color: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: const Text(
              "Save Changes",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

Future<QueryDocumentSnapshot<Map<String, dynamic>>> getUsername(email) async {
  var ref = await FirebaseFirestore.instance
      .collection("UserData")
      .where("email", isEqualTo: email)
      .get();

  var s = ref.docs[0];
  return s;
}

Future<void> UpdateNameAbout(name, about) async {
  final user = FirebaseAuth.instance.currentUser;
  var ref = await FirebaseFirestore.instance
      .collection("UserData")
      .where("email", isEqualTo: user?.email)
      .get();
  ref.docs[0].reference.update({'about': about, 'username': name});

  // final ref = FirebaseDatabase.instance.reference();
  // print("Hello");
  // if(ref)
  // print(ref.docs[0]["username"]);
  // var s = ref.docs[0].reference.update({'about': "cuntttttttttt world hehe!!"});
}