import 'package:backspace/pages/Notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/newsfeed.dart';

import '../api/firebase-api.dart';
import '../components/newsFeed/post-body/posts-text.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';
import 'NFeed.dart';
import 'add-work.dart';

class FindWork extends StatelessWidget {
  const FindWork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDADADA),
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Find Work'),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: MyDelegate(
                          collection: "Posts",
                          fieldName: "content",
                          build: findWorkSearchBuilder),
                    );
                  },
                  icon: Icon(Icons.search, color: Colors.black))),
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
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Posts")
              .where("subspace", isEqualTo: "work")
              .orderBy("created_at", descending: true)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // print(widget.chatID);
            else if (snapshot.connectionState == ConnectionState.waiting) {
              // return Text("leading");

              SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            return ListView(
              shrinkWrap: true,
              // primary: false,
              physics: BouncingScrollPhysics(),
              children:
                  snapshot.data.docs.map<Widget>((DocumentSnapshot document) {
                Map<String, dynamic> post =
                    document.data()! as Map<String, dynamic>;
                var query = FirebaseFirestore.instance
                    .collection("UserData")
                    .where("email", isEqualTo: post["email"])
                    .snapshots();

                return StreamBuilder<QuerySnapshot>(
                  stream: query,
                  builder: (context, AsyncSnapshot snapshot1) {
                    if (!snapshot1.hasData) return Text("");
                    // CircularProgressIndicator();
                    return workPost(
                        userName: snapshot1.data.docs[0]["username"],
                        userimage: snapshot1.data.docs[0]["imageURL"],
                        time: post["created_at"],
                        postcontent: post["content"],
                        // PostImg: post["postImageURL"],
                        // likes: post["likes"],
                        postID: document.id,
                        userAbout: snapshot1.data.docs[0]["about"]
                        // functionalComment: true,
                        );
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddWorkPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
    );
  }
}

class workPost extends StatelessWidget {
  final String userName;
  final String userimage;
  final Timestamp time;
  // final String? PostImg;
  final String postcontent;
  // final int likes;
  final String postID;
  final String? userAbout;
  // final bool functionalComment;

  const workPost(
      {required this.userName,
      required this.userimage,
      required this.time,
      // this.PostImg,
      required this.postcontent,
      // required this.likes,
      required this.postID,
      this.userAbout
      // required this.functionalComment
      });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        top: 10,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          UserIconName(
            userImage: userimage,
            username: userName,
            postTime: time,
            // IMPORTANT __________________________________________________________________________
            userabout: userAbout,
          ),
          PostBody(postSummary: postcontent),
          // if (PostImg != null && PostImg != "") Image.network(PostImg!),
          Divider(height: 1),
        ],
      ),
    );
  }
}


Widget findWorkSearchBuilder(collection, fieldName, query) {
  return FutureBuilder(
    future: FirebaseApi.searchCollection(
        collection, fieldName, query, "subspace", "work"),
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
              return workPost(
                userName: user["username"],
                userimage: user["imageURL"],
                time: post["created_at"],
                postcontent: post["content"],
                postID: post["ItemID"],
                userAbout: user["about"],
              );
            },
          );
        }).toList(),
      );
    },
  );
}
