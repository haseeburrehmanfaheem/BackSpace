// import 'dart:io';

import 'package:backspace/helper/demo_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:backspace/helper/demo_values.dart';




class ViewProfile extends StatefulWidget {
  const ViewProfile({ Key? key }) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.black, fontSize: 18, ),),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Profile() ,
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: CircleAvatar(
                      radius: 70.0, backgroundImage: NetworkImage("assets/images/bill-gates.jpg")),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Bill Gates", style: TextStyle(fontSize: 25,),),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 30.0, right: 30.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black)
                ),
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                      primary: Colors.black.withOpacity(0.5)
                    ),
                    icon: Icon(Icons.message),
                    label: const Text('Message', style: TextStyle( color: Colors.black, fontSize: 14, ),),
                    onPressed: () {
                      
                    },
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10, top: MediaQuery.of(context).size.width / 10),
                child: Text("About", style: TextStyle(color: Colors.black, fontSize: 20, )),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10, top: MediaQuery.of(context).size.width / 25),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DemoValues.postSummary,
              ),
            ),
          )
        ],
      ),
    );
  }
}