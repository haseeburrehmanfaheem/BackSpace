// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../components/newsFeed/post-body/posts-text.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';
import 'Admindrawer.dart';

class Proved extends StatelessWidget {
  const Proved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDADADA),
      //backgroundColor: Colors.white,
      drawer: AdminDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Approved Posts'),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: Icon(Icons.search), onPressed: () {},
                // onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => Noti()),
                //   );
                // },
              ))
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Post(
            userName: "Zeerak",
            userimage: "assets/images/bill-gates.jpg",
            time: "3 min",
            Posttxt:
                "Aagay jaa ke left hou phir right hou phir aik bari si building aye gi uske saath photo lein aur pohnach jaye gay",
            PostImg: "assets/images/Map.png",
          ),
          Post(
            userName: "Haseeb",
            userimage: "assets/images/bill-gates.jpg",
            time: "4 min",
            Posttxt: "Apun Eeeeenstance create kare lai",
            //PostImg: "assets/images/Map.png",
          )
        ],
      ),
    );
  }
}

class Post extends StatelessWidget {
  final String userName;
  final String userimage;
  final String time;
  final String Posttxt;
  final String? PostImg;

  const Post(
      {required this.userName,
      required this.userimage,
      required this.time,
      required this.Posttxt,
      this.PostImg});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          UserIconName(
            userImage: userimage,
            username: userName,
            postTime: time,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
            child: PostBody(postSummary: Posttxt),
            // child:
            //     Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            //   Text(Posttxt,
            //       style: const TextStyle(fontWeight: FontWeight.w500)),
            // ]),
          ),
          if (PostImg != null) Image.asset(PostImg!),
          Divider(height: 1),
          const PostFooter(),
        ],
      ),
    );
  }
}

// Display Like and Comment Post Footer Bar
class PostFooter extends StatefulWidget {
  const PostFooter({Key? key}) : super(key: key);

  @override
  _PostFooter createState() => _PostFooter();
}

class _PostFooter extends State<PostFooter> {
  get style => null;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        OutlineButton(
          child: Text(
            "Delete Post",
            style: TextStyle(fontSize: 20.0, color: Colors.red),
          ),
          highlightedBorderColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {},
        ),
      ],
    );
  }
}
