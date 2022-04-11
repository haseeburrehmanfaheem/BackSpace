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

class AddWorkPage extends StatefulWidget {
  const AddWorkPage({Key? key}) : super(key: key);

  @override
  State<AddWorkPage> createState() => _AddWorkPageState();
}

class _AddWorkPageState extends State<AddWorkPage> {
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
        title: const Text('Add Work'),
        actions: [
          // Icon(Icons.search, color: Colors.black)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: MaterialButton(
                onPressed: () {
                // async {
                  // String? URL = "";
                  // final users = FirebaseAuth.instance.currentUser;
                  // String? emailID = users?.email;
                  // DateTime currentPhoneDate = DateTime.now(); //DateTime
                  // Timestamp myTimeStamp =
                  //     Timestamp.fromDate(currentPhoneDate); //To TimeStamp
                  // DateTime myDateTime =
                  //     myTimeStamp.toDate(); // TimeStamp to DateTime
                  // if (image != null) {
                  //   final fileName = basename(image!.path);
                  //   // print("current phone data is: $myDateTime");
                  //   final storagePath =
                  //       'UserImages/${emailID}_${myDateTime}_$fileName';
                  //   URL = await FirebaseApi.uploadFile(storagePath, image!);
                  //   // print(URL);
                  // }
                  // addDataToPost(emailID, URL, postcontentController.text,
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
      body: 
      Stack(children: [
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
          child: AddWorkForm(postcontentController: postcontentController)
          // Text("xx"),
          // AddWorkForm(
            // postcontentController: postcontentController,
            // changeState: changeState,
          // ),
        ),
      ]
      ),
    );
  }
}



class AddWorkForm extends StatefulWidget {
  final TextEditingController postcontentController;

  final Function(File)? changeState;

  const AddWorkForm({
    Key? key,
    this.changeState,
    required this.postcontentController,
  }) : super(key: key);

  @override
  AddWorkFormState createState() => AddWorkFormState();
}

class AddWorkFormState extends State<AddWorkForm> {
  final _formKey = GlobalKey<FormState>();
  // File? image;

  // Future handleChoosefromgallery() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);

  //     if (image == null) return;

  //     final imageTemp = File(image.path);

  //     setState(() => this.image = imageTemp);
  //     widget.changeState!(imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // Future handleTakephoto() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);

  //     if (image == null) return;

  //     final imageTemp = File(image.path);

  //     setState(() => this.image = imageTemp);
  //     widget.changeState!(imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return (Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
            // mainAxisSize: MainAxisSize.min, // added line
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: widget.postcontentController,
                  onTap: () {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Add Work",
                    fillColor: const Color(0xfff9f9fa),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () async {
                        // if (formGlobalKey.currentState!.validate()) {
                        //   // print(commentController.text);
                        //   await updateCommentInDB(
                        //       commentController.text, widget.post_id);
                        //   // Navigator.pushReplacement(context,Postscomment(likes: widget.likes, post_id: widget.post_id, userName: widget.userName, userimage: widget.userimage, time: widget.time, PostImg: widget.PostImg, postcontent: widget.postcontent))
                        // }
                      },
                    ),
                  ),
                ),
              ),
              // IconButton(
              //     onPressed: () {
              //       // handleTakephoto();
              //     }, //Open Camera here
              //     icon: const Icon(Icons.ca)),
              // IconButton(
              //     onPressed: handleChoosefromgallery, //Open Gallery here
              //     icon: const Icon(Icons.photo)),
            ]),
      ),
    ));
  }
}