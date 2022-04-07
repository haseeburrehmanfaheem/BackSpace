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
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
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
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
