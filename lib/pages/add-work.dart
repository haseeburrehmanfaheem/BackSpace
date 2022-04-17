import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:path/path.dart';
import 'package:backspace/api/firebase-api.dart';
import 'package:backspace/pages/NFeed.dart';
import 'package:backspace/pages/Notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'EditProfile.dart';
import 'FindWork.dart';
import 'newsfeed.dart';

class AddWorkPage extends StatefulWidget {
  const AddWorkPage({Key? key}) : super(key: key);

  @override
  State<AddWorkPage> createState() => _AddWorkPageState();
}

class _AddWorkPageState extends State<AddWorkPage> {
  final TextEditingController workcontentController = TextEditingController();
  File? image;
  CollectionReference users = FirebaseFirestore.instance.collection('posts');
  void changeState(imgSrc) {
    setState(() => image = imgSrc);
  }

  createPost({
    required String postContent,
    String? imageUrl,
    required String userEmail,
  }) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        title: const Text('Add Work'),
        actions: [
          // Icon(Icons.search, color: Colors.black)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: MaterialButton(
                onPressed: () async {
                  // if()
                  if (_formKey.currentState!.validate()) {
                    print(workcontentController.text);
                    String URL = "";
                    final users = await FirebaseAuth.instance.currentUser;
                    String? emailID = users?.email;
                    DateTime currentPhoneDate = DateTime.now(); //DateTime
                    Timestamp myTimeStamp =
                        Timestamp.fromDate(currentPhoneDate); //To TimeStamp
                    DateTime myDateTime =
                        myTimeStamp.toDate(); // TimeStamp to DateTime
                    var username = await getUsername(emailID);
                    var userName = username["username"];
                    print(userName);

                    addWorkToPost(
                        emailID, URL, workcontentController.text, myDateTime);
                    // setState(() => {});
                    // Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => BottomNavigation()));
                    // Navigator.pushReplacement(
                    //     context, MaterialPageRoute(builder: (_) => FindWork()));

                    // username posttable
                    // user image url posttable
                    // content controller
                    // time local
                    // subspace
                  }
                  // async {

                  //     context, myDateTime);
                  // if (image != null) {
                  //   final fileName = basename(image!.path);
                  //   // print("current phone data is: $myDateTime");
                  //   final storagePath =
                  //       'UserImages/${emailID}_${myDateTime}_$fileName';
                  //   URL = await FirebaseApi.uploadFile(storagePath, image!);
                  //   // print(URL);
                  // }
                  // addDataToPost(emailID, URL, workcontentController.text,
                  //     context, myDateTime);
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (_) => BottomNavigation()));
                  // save content and likes and jkadnfknadkjfna
                },
                child: const Text("Post",
                    style: TextStyle(color: Colors.blue, fontSize: 18))),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Stack(children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: image != null
              ? Image.file(
                  image!,
                  fit: BoxFit.cover,
                )
              : Container(),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: AddWorkForm(workcontentController: workcontentController)

            // set
            // Text("xx"),
            // AddWorkForm(
            // workcontentController: workcontentController,
            // changeState: changeState,
            // ),
            ),
      ]),
    );
  }
}

// final TextEditingController workcontentController;
class AddWorkForm extends StatefulWidget {
  final TextEditingController workcontentController;

  final Function(File)? changeState;

  const AddWorkForm({
    Key? key,
    this.changeState,
    required this.workcontentController,
  }) : super(key: key);

  @override
  AddWorkFormState createState() => AddWorkFormState();
}

final _formKey = GlobalKey<FormState>();

class AddWorkFormState extends State<AddWorkForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: Row(children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: widget.workcontentController,
                    onTap: () {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Add Work",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              ),
                          borderRadius: BorderRadius.circular(25.0),
                      ),
                      fillColor: Colors.grey.withOpacity(0.2),
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

addWorkToPost(emailID, imageURL, content, myDateTime) async {
  var ref = await FirebaseFirestore.instance.collection("Posts");

  ref.add({
    "email": emailID,
    "imageURL": imageURL,
    "content": content,
    "likes": 0,
    "created_at": myDateTime,
    "subspace": "work",
    "approved": true,
  }).then((value) async {
    // print(value.id);
    // var comments_table =
    //     await FirebaseFirestore.instance.collection("Comments");
    // comments_table.add({"email": });
  }).catchError((error) => print("Failed to add user: $error"));
  return;
}
