import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:backspace/api/firebase-api.dart';
import 'package:backspace/pages/NFeed.dart';
import 'package:backspace/pages/Notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  File? image;
  CollectionReference users = FirebaseFirestore.instance.collection('');
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
                  if (image != null) {
                    final fileName = basename(image!.path);
                    final storagePath = 'UserImages/$fileName';
                    final String? downloadUrl =
                        await FirebaseApi.uploadFile(storagePath, image!);
                  }
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
            changeState: changeState,
          ),
        ),
      ]),
    );
  }
}
