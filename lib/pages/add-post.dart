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

import 'newsfeed.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController postcontentController = TextEditingController();
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
        title: const Text('Add Post'),
        actions: [
          // Icon(Icons.search, color: Colors.black)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: MaterialButton(
                onPressed: () async {
                  // if (_formKey.currentState!.validate()){}
                  String? URL = "";
                  final users = FirebaseAuth.instance.currentUser;
                  String? emailID = users?.email;
                  DateTime currentPhoneDate = DateTime.now(); //DateTime
                  Timestamp myTimeStamp =
                      Timestamp.fromDate(currentPhoneDate); //To TimeStamp
                  DateTime myDateTime =
                      myTimeStamp.toDate(); // TimeStamp to DateTime
                  if (image != null) {
                    final fileName = basename(image!.path);
                    // print("current phone data is: $myDateTime");
                    final storagePath =
                        'UserImages/${emailID}_${myDateTime}_$fileName';
                    URL = await FirebaseApi.uploadFile(storagePath, image!);
                    // print(URL);
                  }
                  addDataToPost(emailID, URL, postcontentController.text,
                      context, myDateTime);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => BottomNavigation()));
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
          child: AddPostForm(
              postcontentController: postcontentController,
              changeState: changeState,
              showImagesIcons: true,
              hintText: "Add Post"),
        ),
      ]),
    );
  }
}

addDataToPost(emailID, imageURL, content, context, myDateTime) async {
  var ref = await FirebaseFirestore.instance.collection("Posts");
  

  ref.add({
    "email": emailID,
    "imageURL": imageURL,
    "content": content,
    "likes": 0,
    "created_at": myDateTime,
    "subspace": null,
    "approved": false
  }).then((value) async {
    // print(value.id);
    // var comments_table =
    //     await FirebaseFirestore.instance.collection("Comments");
    // comments_table.add({"email": });
  }).catchError((error) => print("Failed to add user: $error"));
  return;
}
