import 'package:backspace/pages/NFeed.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/Subspace.dart';
import 'package:backspace/pages/FindWork.dart';
import 'package:backspace/pages/Messages.dart';
import 'package:backspace/pages/Instructor.dart';
import 'package:backspace/pages/NewsFeed.dart';

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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(.50),
        showUnselectedLabels: true,
        selectedFontSize: 14,
        unselectedFontSize: 14,
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
