// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:backspace/pages/ApprovedPosts.dart';
import 'package:backspace/pages/PendingPosts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../api/firebase-api.dart';
import 'Admindrawer.dart';
import 'package:path/path.dart';
import 'EditProfile.dart';

class Event extends StatefulWidget {
  Event({Key? key}) : super(key: key);

  @override
  EventState createState() => EventState();
}

class EventState extends State<Event> {
  // const EventState({Key? key}) : super(key: key);

  @override
  // File image;
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
        title: const Text('Add Event'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),

          )
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(child: Subspaceform()),
    );
  }
}

var EventController = TextEditingController();
GlobalKey<FormState> EventForm = GlobalKey<FormState>();

class Subspaceform extends StatefulWidget {
  File? image = null;
  Subspaceform({Key? key}) : super(key: key);

  @override
  State<Subspaceform> createState() => SubspaceformState();
}

class SubspaceformState extends State<Subspaceform> {
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              "Add Event",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              "Event Details",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: EventForm,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter something";
                  } else {
                    return null;
                  }
                },
                controller: EventController,
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
          // if (widget.image == null) ?
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
              style:
                  TextButton.styleFrom(primary: Colors.black.withOpacity(0.5)),
              icon: Icon(Icons.camera_alt_outlined),
              label: const Text(
                'Add Image',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              onPressed: () {
                // buildImage('assets/images/bill-gates.jpg');
                handleChoosefromgallery();
              },
            ),
          ),


          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8)),

          Padding(
            padding: EdgeInsets.only(left: 24, top: 80, right: 24),
            child: MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () async {
                if (EventForm.currentState!.validate()) {
                  // print("wassup");
                  print(EventController.text);

                  String? URL = "";
                  final users = FirebaseAuth.instance.currentUser;
                  String? emailID = users?.email;
                  DateTime currentPhoneDate = DateTime.now(); //DateTime
                  Timestamp myTimeStamp =
                      Timestamp.fromDate(currentPhoneDate); //To TimeStamp
                  DateTime myDateTime =
                      myTimeStamp.toDate(); // TimeStamp to DateTime
                  if (widget.image != null) {
                    final fileName = basename(widget.image!.path);
                    // print(fileName);
                    // print("current phone data is: $myDateTime");
                    final storagePath =
                        'UserImages/${emailID}_${myDateTime}_$fileName';
                    URL = await FirebaseApi.uploadFile(
                        storagePath, widget.image!);
                    // print(URL);
                  }
                  // Navigator.pop(context);
                  AddEventToDB(emailID, URL, EventController.text, myDateTime);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Proved()));

                }
              },
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              child: const Text(
                "Add Event",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// if (formkey1.currentState!.validate()

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



AddEventToDB(emailID, URL, text, myDateTime) async {
  var ref = await FirebaseFirestore.instance.collection("Posts");

  ref.add({
    "email": emailID,
    "imageURL": URL,
    "content": text,
    "likes": 0,
    "created_at": myDateTime,
    "subspace": null,
    "approved": true
  });
}
