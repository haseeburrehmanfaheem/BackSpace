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
// import 'package:backspace/pages/Instructor.dart';

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

class MyDrawer extends StatelessWidget {
  CollectionReference user2 = FirebaseFirestore.instance.collection('UserData');
  final user1 = FirebaseAuth.instance.currentUser;
  // final CollectionReference noticeCollection= FirebaseFirestore.instance.collection('UserData');

  // FirebaseFirestore.instance
  //   .collection('UserData')
  //   .doc(userId)
  //   .get()
  //   .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       print('Document exists on the database');
  //     }
  //   });
// final Query unapproved = noticeCollection.where("status", isEqualTo: "unapproved")

  // // CollectionReference users = FirebaseFirestore.instance.collection('UserData');
  // fetchSocial() async {
  //   var value = await _socialMessage.get();
  //   print(value);
  // }

  @override
  Widget build(BuildContext context) {
    String? email = "backspace";
    if (user1 != null) {
      email = user1?.email!;
    }
    //  else {
    //   print("on noo");
    // }
    // QuerySnapshot eventsQuery =  user2
    // .where('email', isEqualTo: email).get();
    print(email);
    var x = (user2.where('email', isEqualTo: email).snapshots()).toString();
    String y = user2.doc().get().toString();
    // .get()
    // .then((value) => {print(value), print("hello")});

    print(x);
    print(y);
    return Container(
      // height: 100,
      margin: EdgeInsets.only(top: 22),
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
            Text(
              email!,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            ListTile(
                leading: Icon(Icons.build_rounded),
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
                leading: Icon(Icons.power_settings_new, color: Colors.red),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(builder: (context) => Home()));
                  // Navigator.push(
                  // context, MaterialPageRoute(builder: (context) => Home()));
                }),
          ],
        ),
      ),
    );
  }
}
