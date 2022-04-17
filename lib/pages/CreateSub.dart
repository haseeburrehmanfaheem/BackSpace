// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:backspace/api/firebase-api.dart';
import 'package:backspace/pages/AddEvent.dart';
import 'package:backspace/pages/Admindrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'ApprovedPosts.dart';

var SubspaceNameController = TextEditingController();
var SubspaceDescriptionController = TextEditingController();
GlobalKey<FormState> Namekey = GlobalKey<FormState>();
GlobalKey<FormState> Aboutkey = GlobalKey<FormState>();

class CreateSub extends StatelessWidget {
  const CreateSub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AdminDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Create SubSpace'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            
          )
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(child: SubspaceForm()),
    );
  }
}

class SubspaceForm extends StatefulWidget {
  File? image = null;
  @override
  State<SubspaceForm> createState() => _SubspaceFormState();
}

class _SubspaceFormState extends State<SubspaceForm> {
  Future handleChoosefromgallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => widget.image = imageTemp);
      // widget.changeState!(imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            "Create SubSpace",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 16),
          child: Stack(children: [
            SizedBox(
              width: 200,
              // double.infinity,
              height: 200,
              child: widget.image != null
                  ? Image.file(
                      widget.image!,
                      fit: BoxFit.cover,
                    )
                  : Container(),
            ),
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30.0, left: 20.0),
          padding: const EdgeInsets.only(
              top: 2.0, bottom: 2.0, left: 30.0, right: 30.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black)),
          child: TextButton.icon(
            style: TextButton.styleFrom(primary: Colors.black.withOpacity(0.5)),
            icon: Icon(Icons.camera_alt_outlined),
            label: const Text(
              'Add Image',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            onPressed: () {
              handleChoosefromgallery();
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            "Subspace Name",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: Namekey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter something";
                } else {
                  return null;
                }
              },
              controller: SubspaceNameController,
              // initialValue: txt.data,
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
          child: Form(
            key: Aboutkey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter something";
                } else {
                  return null;
                }
              },
              controller: SubspaceDescriptionController,
              // initialValue: txt.data,
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
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, top: 80, right: 24),
          child: MaterialButton(
            minWidth: double.infinity,
            height: 60,
            onPressed: () async {
              if (Namekey.currentState!.validate() &&
                  Aboutkey.currentState!.validate()) {
                // print("wassup");
                print(SubspaceNameController.text);
                print(SubspaceDescriptionController.text);
                String? URL =
                    "https://firebasestorage.googleapis.com/v0/b/backspace-current.appspot.com/o/UserImages%2Fsubspacedefaultimage.png?alt=media&token=971f5a5e-80dd-4573-b41e-fcf31cd1a2ab";
                if (widget.image != null) {
                  final fileName = basename(widget.image!.path);
                  // print(fileName);
                  // print("current phone data is: $myDateTime");
                  final storagePath =
                      'UserImages/${SubspaceDescriptionController.text}_$fileName';
                  URL =
                      await FirebaseApi.uploadFile(storagePath, widget.image!);
                  // print(URL);
                }
                String name = SubspaceNameController.text;
                String description = SubspaceDescriptionController.text;
                await SaveSubspaceInDb(name, description, URL);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Proved()));
              }
            },
            color: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: const Text(
              "Create SubSpace",
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

Widget buildImage(s) {
  return Center(
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

SaveSubspaceInDb(name, description, URL) async {
  var ref = await FirebaseFirestore.instance.collection("SubSpace");

  ref.add({
    "name": name,
    "imageURL": URL,
    "description": description,
  });
}
