// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:backspace/pages/AddEvent.dart';
import 'package:backspace/pages/Admindrawer.dart';
import 'package:flutter/material.dart';

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
            // child: IconButton(
            //   icon: Icon(Icons.search), onPressed: () {},
            //   // onPressed: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => Noti()),
            //   );
            // },
          )
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(child: SubspaceForm()),
    );
  }
}

class SubspaceForm extends StatelessWidget {
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
            onPressed: () {},
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
            onPressed: () {
              if (Namekey.currentState!.validate() &&
                  Aboutkey.currentState!.validate()) {
                // print("wassup");
                print(SubspaceNameController.text);
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
