import 'package:backspace/pages/EditProfile.dart';
import 'package:backspace/pages/FAQ.dart';
import 'package:backspace/pages/Guide.dart';
import 'package:backspace/pages/LumsMap.dart';
import 'package:backspace/pages/NFeed.dart';
import 'package:backspace/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/Subspace.dart';
import 'package:backspace/pages/FindWork.dart';
import 'package:backspace/pages/Messages.dart';
import 'package:backspace/pages/Instructor.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Feed(),
    Instructor(),
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

    // var string1;
    // var x1 = FirebaseFirestore.instance.collection('UserData').get();
    // var x2 = x1.then((QuerySnapshot querySnapshot) {
      // querySnapshot.docs.forEach((doc) {
        // if (doc["email"] == s) {
          // print(doc["username"]);
          // return (doc["username"]);
        // }
      // });
    // });
    // print("hello");
    // print(s);

    // var username = getUsername(s).then((value) => {print(value)});
    // var username = getUsername(s);
    // print(username);

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
            FutureBuilder<String>(
              future: getUsername(s),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data ?? " ",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  );
                } else {
                  return Text(
                    "Loading data...",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  );
                }
              },
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
            const Text(
              'Backspace',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            ListTile(
                leading: const Icon(Icons.build_rounded),
                title: Text('Edit Profile'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfile()));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Map()));
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

Future<String> getUsername(email) async {
  var ref = await FirebaseFirestore.instance
      .collection("UserData")
      .where("email", isEqualTo: email)
      .get();
  // final ref = FirebaseDatabase.instance.reference();
  // print("Hello");
  // if(ref)
  // print(ref.docs[0]["username"]);
  var s = ref.docs[0]["username"];
  return s ?? " ";
}
