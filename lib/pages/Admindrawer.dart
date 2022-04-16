// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:backspace/pages/AddEvent.dart';
import 'package:backspace/pages/ApprovedPosts.dart';
import 'package:backspace/pages/CreateSub.dart';
import 'package:backspace/pages/PendingPosts.dart';
import 'package:backspace/pages/Subspace.dart';
import 'package:backspace/pages/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  _AdminDrawer createState() => _AdminDrawer();
}

class _AdminDrawer extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      margin: const EdgeInsets.only(top: 50),
      height: MediaQuery.of(context).size.height * 0.92,
      // height: EdgeInsets.only({double top: 50.0, double bottom: 0.0}),
      // width: 50,

      child: Drawer(
        child: ListView(
          // padding: EdgeInsets.zero,
          padding: EdgeInsets.only(top: 50),
          // padding: EdgeInsets.only(top: 10),
          // margin: EdgeInsets.all(80),
          children: <Widget>[
            ListTile(
                leading: const Icon(Icons.build_rounded),
                title: Text('Pending Posts'),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Pending()));
                }),
            ListTile(
                leading: Icon(Icons.live_help_outlined),
                title: Text('Approved Posts'),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Proved()));
                }),
            ListTile(
                leading: Icon(Icons.fmd_good),
                title: Text('Add Event'),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Event()));
                }),
            ListTile(
                leading: Icon(Icons.follow_the_signs),
                title: Text('Block Users'),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Block()));
                }),
            ListTile(
                leading: Icon(Icons.follow_the_signs),
                title: Text('Create SubSpace'),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateSub()));
                }),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const Guide()));
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(builder: (context) => Home()));
              },
              leading: const Icon(Icons.power_settings_new, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
