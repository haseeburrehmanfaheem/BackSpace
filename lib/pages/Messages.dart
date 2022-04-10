// ignore_for_file: prefer_const_constructors

import 'package:backspace/components/newsFeed/post-header/user-icon-name.dart';
import 'package:backspace/pages/Notification.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/newsfeed.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Messages', style: TextStyle(fontFamily: "Poppins")),
        actions: [
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Icon(Icons.search, color: Colors.black)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: Icon(Icons.notifications_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Noti()),
                  );
                },
              ))
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(children: const <Widget>[
        Message(
          userImg: "assets/images/bill-gates.jpg",
          name: "Zeerak",
          Time: "2 sec",
          posttext: "Bhai SE ka kaam kab khatam hona?",
        ),
        Message(
          userImg: "assets/images/bill-gates.jpg",
          name: "Haseeb",
          Time: "3 sec",
          posttext: "Bhai SE ka kaam kab khatam honaQddwdq?",
        )
        // userName: "Zeerak",
        // imagePath: "assets/images/bill-gates.jpg",
        // time: "2 sec",
        // text: "hi guys")
      ]),
    );
  }
}

class Message extends StatelessWidget {
  final String userImg;
  final String Time;
  final String name;
  final String posttext;
  // ignore: use_key_in_widget_constructors
  const Message(
      {required this.userImg,
      required this.name,
      required this.Time,
      required this.posttext});
  @override
  Widget build(BuildContext context) {
    return Container(
        //clipBehavior: Clip.antiAlias,
        child: Column(children: [
      const Padding(padding: EdgeInsets.only(top: 10, left: 0)),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 10)),
                CircleAvatar(
                  backgroundImage: AssetImage(userImg),
                  radius: 30,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        Text(posttext,
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 15, top: 5),
              child: Text(
                Time,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
      const Padding(padding: EdgeInsets.only(bottom: 10)),
      Divider(height: 1),
    ]));
    // elevation: 5,
    //)
  }
}
