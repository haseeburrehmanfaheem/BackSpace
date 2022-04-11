// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../components/newsFeed/post-body/posts-text.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';
import 'Admindrawer.dart';

class Pending extends StatelessWidget {
  const Pending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffDADADA),
        drawer: AdminDrawer(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: const Text('Pending Posts'),
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
              userName: "Aswad",
              userimage: "assets/images/bill-gates.jpg",
              time: "3 min",
              Posttxt: "Stop littering pls :(",
              PostImg: "assets/images/keys.jpg",
            )
          ],
        ));
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
            "Approve",
            style: TextStyle(fontSize: 20.0, color: Colors.green),
          ),
          highlightedBorderColor: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {},
        ),
        const Padding(padding: EdgeInsets.only(right: 70)),
        const Padding(padding: EdgeInsets.only(left: 70.0)),
        Align(
            alignment: Alignment.centerRight,
            child: OutlineButton(
              child: Text(
                "Reject",
                style: TextStyle(fontSize: 20.0, color: Colors.red),
              ),
              highlightedBorderColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () {},
            )),
      ],
    );
  }
}
