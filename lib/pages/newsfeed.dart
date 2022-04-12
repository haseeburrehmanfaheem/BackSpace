// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:backspace/pages/EditProfile.dart';
import 'package:backspace/pages/Instructor.dart';
import 'package:backspace/pages/UserProfile.dart';

import 'package:backspace/pages/FAQ.dart';
import 'package:backspace/pages/Guide.dart';
import 'package:backspace/pages/InstructorProfile.dart';
import 'package:backspace/pages/LumsMap.dart';
import 'package:backspace/pages/NFeed.dart';
import 'package:backspace/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/Subspace.dart';
import 'package:backspace/pages/FindWork.dart';
import 'package:backspace/pages/Messages.dart';
import 'package:backspace/pages/InstructorProfile.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Feed(),
    Instructors(),
    // UserProfile(),
    FindWork(),
    SubSpace(),
    Messages()
  ];

  void OnTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(.50),
        showUnselectedLabels: true,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        // type: BottomNavigation
        onTap: OnTappedBar,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Instructors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            label: 'Work',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum_outlined),
            label: 'Subspace',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Messages',
          ),
        ],
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawer createState() => _MyDrawer();
}

class _MyDrawer extends State<MyDrawer> {
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference cl =
      FirebaseFirestore.instance.collection('UserData');

  @override
  Widget build(BuildContext context) {
    String? s = "backspace";
    if (user != null) {
      s = user?.email;
    }

    return Container(
      // height: 100,
      margin: const EdgeInsets.only(top: 22),
      height: MediaQuery.of(context).size.height * 0.90,
      // height: EdgeInsets.only({double top: 50.0, double bottom: 0.0}),
      // width: 50,

      child: Drawer(
        child: ListView(
          // padding: EdgeInsets.zero,
          padding: EdgeInsets.only(top: 50),
          // padding: EdgeInsets.only(top: 10),
          // margin: EdgeInsets.all(80),
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 1, top: 20),
                child:
                    FutureBuilder<QueryDocumentSnapshot<Map<String, dynamic>>>(
                  future: getUsername(s),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String s = snapshot.data?.data()["imageURL"];
                      return Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: CircleAvatar(
                                radius: 40.0, backgroundImage: NetworkImage(s)),
                          ),
                        ],
                      );
                    } else {
                      return Text("Loading...");
                    }
                  },
                )

                // Column(
                //   children: [
                //     FittedBox(
                //       fit: BoxFit.fill,
                //       child: CircleAvatar(
                //           radius: 40.0,
                //           backgroundImage: NetworkImage(
                //               "https://firebasestorage.googleapis.com/v0/b/backspace-current.appspot.com/o/UserImages%2Fdefault.png?alt=media&token=dc5d36d7-0cb9-4b94-a36d-2f58bf776be5")),
                //     ),
                //   ],
                // )
                // ,
                ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: FutureBuilder<String>(
                future: getUsername1(s),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data ?? " ",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black.withOpacity(.50),
                      ),
                    );
                  } else {
                    return Text(
                      "Loading data...",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black.withOpacity(.50),
                      ),
                    );
                  }
                },
              ),
            ),
            // Expanded(
            //   child: StreamBuilder(
            //     stream: cl.snapshots(),
            //     // initialData: initialData,
            //     builder: (BuildContext context, AsyncSnapshot snapshot) {
            //       return ListView(
            //         children: snapshot.data.docs
            //             .map<Widget>((e) => {
            //                   ListTile(
            //                     title: e["username"],
            //                   )
            //                 })
            //             .toList(),
            //       );
            //     },
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 20),
              child: Text(
                s!,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
                leading: const Icon(Icons.build_rounded),
                title: Text('Edit Profile'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                }),
            ListTile(
                leading: Icon(Icons.live_help_outlined),
                title: Text('FAQs'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const FAQ()));
                }),
            ListTile(
                leading: Icon(Icons.fmd_good),
                title: Text('Lums Map'),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Map1()));
                }),
            ListTile(
                leading: Icon(Icons.follow_the_signs),
                title: Text('Freshman Guide'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Guide()));
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

Future<String> getUsername1(email) async {
  var ref = await FirebaseFirestore.instance
      .collection("UserData")
      .where("email", isEqualTo: email)
      .get();
  var s = ref.docs[0]["username"];
  return s ?? " ";
}

// Future<QueryDocumentSnapshot<Map<String, dynamic>>> getUsername5(email) async {
//   var ref = await FirebaseFirestore.instance
//       .collection("UserData")
//       .where("email", isEqualTo: email)
//       .get();

//   var s = ref.docs[0];
//   return s;
// }