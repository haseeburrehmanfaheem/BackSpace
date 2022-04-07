import 'package:backspace/pages/EditProfile.dart';
import 'package:backspace/pages/FAQ.dart';
import 'package:backspace/pages/Guide.dart';
import 'package:backspace/pages/LumsMap.dart';
import 'package:backspace/pages/NFeed.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/Subspace.dart';
import 'package:backspace/pages/FindWork.dart';
import 'package:backspace/pages/Messages.dart';
import 'package:backspace/pages/Instructor.dart';

class BottomNavigation extends StatefulWidget {
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
  @override
  Widget build(BuildContext context) {
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
            Text('Backspace', style: TextStyle(fontSize: 30,),),
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
              title: Text('Logout' , style: TextStyle(color: Colors.red),),
            ),
          ],
        ),
      ),
    );
  }
}