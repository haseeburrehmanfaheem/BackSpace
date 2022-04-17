// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../api/firebase-api.dart';
import '../components/newsFeed/post-body/posts-text.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';
import 'Admindrawer.dart';
import 'ApprovedPosts.dart';
import 'NFeed.dart';

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
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: MyDelegate(
                            collection: "Posts",
                            fieldName: "content",
                            build: pendingPostSearchBuilder),
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
                  final posts = snapshot.data;
                  return Column(
                    children: <Widget>[
                      for (var post in posts)
                        if ((post["subspace"] == null ||
                                post["subspace"] == "") &&
                            (post["approved"] == false))

                          // displaying in newsfeed ////////////////////////////
                          // Text("data")
                          AdminPost2(
                            userName: post["username"],
                            userimage: post["userImageURL"],
                            time: post["created_at"],
                            Posttxt: post["content"],
                            PostImg: post["postImageURL"],
                            postid: post["postID"],
                          ),

                      // Post(
                      //   userName: post["username"],
                      //   userimage: post["userImageURL"],
                      //   time: "5 min",
                      //   postcontent: post["content"],
                      //   PostImg: post["postImageURL"],
                      //   likes: post["likes"],
                      //   postID: post["postID"],
                      //   functionalComment: true,
                      //   userAbout: post["userAbout"],
                      // ),
                    ],
                  );
                })
            // Post(
            //   userName: "Aswad",
            //   userimage: "assets/images/bill-gates.jpg",
            //   time: "3 min",
            //   Posttxt: "Stop littering pls :(",
            //   PostImg: "assets/images/keys.jpg",
            // )
          ],
        ));
  }
}

class AdminPost2 extends StatelessWidget {
  final String userName;
  final String userimage;
  final Timestamp time;
  final String Posttxt;
  final String? PostImg;
  final String postid;

  const AdminPost2(
      {required this.userName,
      required this.userimage,
      required this.time,
      required this.Posttxt,
      this.PostImg,
      required this.postid});

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
            // IMPORTANT_________________________________________________________________
            // userabout: "",
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
          if (PostImg != null && PostImg != "") Image.network(PostImg!),
          // if (PostImg != null && PostImg != "") Image.network(PostImg!),
          Divider(height: 1),
          PostFooter(
            id: postid,
          ),
        ],
      ),
    );
  }
}

// Display Like and Comment Post Footer Bar
class PostFooter extends StatefulWidget {
  var id;
  PostFooter({Key? key, required this.id}) : super(key: key);

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
            "Approve",
            style: TextStyle(fontSize: 14.0, color: Colors.green),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              width: 1.0,
              color: Colors.green,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () {
            print(widget.id);
            setIDTrue(widget.id);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Pending()));
          },
        ),
        const Padding(padding: EdgeInsets.only(right: 70)),
        const Padding(padding: EdgeInsets.only(left: 70.0)),
        Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                DeletePostFromDB(widget.id);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Pending()));
              },
            )),
      ],
    );
  }
}

setIDTrue(id) {
  var posts = FirebaseFirestore.instance.collection('Posts');
  posts.doc(id) // <-- Doc ID where data should be updated.
      .update({'approved': true});
}

DeletePostFromDB(id) {
  var posts = FirebaseFirestore.instance.collection('Posts');
  posts
      .doc(id) // <-- Doc ID where data should be deleted.
      .delete();
}

Widget pendingPostSearchBuilder(collection, fieldName, query) {
  return FutureBuilder(
    future: FirebaseApi.searchCollection(
        collection, fieldName, query, "approved", false),
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
              return AdminPost2(
                userName: user["username"],
                userimage: user["imageURL"],
                time: post["created_at"],
                Posttxt: post["content"],
                PostImg: post["imageURL"],
                postid: post["ItemID"],
              );
            },
          );
        }).toList(),
      );
    },
  );
}
