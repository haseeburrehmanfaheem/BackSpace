// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../api/firebase-api.dart';
import '../components/newsFeed/post-body/posts-text.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';
import 'Admindrawer.dart';
import 'NFeed.dart';
import 'PendingPosts.dart';

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
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: MyDelegate(
                          collection: "Posts",
                          fieldName: "content",
                          build: approvedPostSearchBuilder),
                    );
                  },
                  icon: Icon(Icons.search, color: Colors.black))),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          FutureBuilder(
              future: completePost(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.40),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                // else if()
                final posts = snapshot.data;
                return Column(
                  children: <Widget>[
                    for (var post in posts)
                      if ((post["subspace"] == "") &&
                          (post["approved"] == true))
                        AdminPost(
                          userName: post["username"],
                          userimage: post["userImageURL"],
                          time: post["created_at"],
                          Posttxt: post["content"],
                          PostImg: post["postImageURL"],
                          docid: post["postID"],
                        ),
                  ],
                );
              })
        ],
      ),
    );
  }
}

class AdminPost extends StatelessWidget {
  final String userName;
  final String userimage;
  final Timestamp time;
  final String Posttxt;
  final String? PostImg;
  String docid;

  AdminPost(
      {required this.userName,
      required this.userimage,
      required this.time,
      required this.Posttxt,
      this.PostImg,
      required this.docid});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          UserIconName(
            userImage: userimage,
            username: userName,
            postTime: time,
            // userabout: "",
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
            child: PostBody(postSummary: Posttxt),
          ),
          if (PostImg != null && PostImg != "") Image.network(PostImg!),
          Divider(height: 1),
          PostFooter(
            docid: docid,
          ),
        ],
      ),
    );
  }
}

// Display Like and Comment Post Footer Bar
class PostFooter extends StatefulWidget {
  String docid;
  PostFooter({Key? key, required this.docid}) : super(key: key);

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
        OutlinedButton(
          //color: Colors.green,
          child: Text(
            "Reject",
            style: TextStyle(fontSize: 14.0, color: Colors.red),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              width: 1.0,
              color: Colors.red,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () {
            DeletePostFromDB(widget.docid);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Proved()));
          },
        ),
      ],
    );
  }
}

Widget approvedPostSearchBuilder(collection, fieldName, query) {
  return FutureBuilder(
    future: FirebaseApi.searchCollection(
        collection, fieldName, query, "approved", true),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (snapshot.data.isEmpty) {
        return Column(
          children: const [
            SizedBox(height: 100),
            Center(
              child: Text("No Results Found",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            )
          ],
        );
      }
      return ListView(
        shrinkWrap: true,
        children: snapshot.data.map<Widget>((post) {
          return FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("UserData")
                .where("email", isEqualTo: post["email"])
                .get(),
            builder: (BuildContext context, AsyncSnapshot userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final user = userSnapshot.data.docs[0].data();
              return AdminPost(
                userName: user["username"],
                userimage: user["imageURL"],
                time: post["created_at"],
                Posttxt: post["content"],
                PostImg: post["imageURL"],
                docid: post["ItemID"],
              );
            },
          );
        }).toList(),
      );
    },
  );
}
