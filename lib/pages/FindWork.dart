import 'package:backspace/pages/Notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/newsfeed.dart';

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
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
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
      body: Center(
        //     child: StreamBuilder(
        //   stream: FirebaseFirestore.instance
        //       .collection("Posts")
        //       .where("subspace", isEqualTo: "work")
        //       .snapshots(),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     // print(widget.chatID);
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return SizedBox(
        //         height: MediaQuery.of(context).size.height / 1.3,
        //         child: Center(
        //           child: CircularProgressIndicator(),
        //         ),
        //       );
        //     }
        //     if (snapshot.hasError) {
        //       return Text("Something went wrong");
        //     }
        //     return ListView(
        //       // shrinkWrap: true,
        //       children:
        //           snapshot.data.docs.map<Widget>((DocumentSnapshot document) {
        //         Map<String, dynamic> post =
        //             document.data()! as Map<String, dynamic>;
        //         var query = FirebaseFirestore.instance
        //             .collection("UserData")
        //             .where("email", isEqualTo: post["email"])
        //             .snapshots();

        //         return StreamBuilder<QuerySnapshot>(
        //           stream: query,
        //           builder: (context, AsyncSnapshot snapshot1) {
        //             if (!snapshot.hasData) return Text("Loading...");

        //             // right here is where you need to put the widget that you
        //             // want to create for the history entries in snapshot.data...
        //             return Text(
        //                 "${post["content"]} ${snapshot1.data.docs[0]["username"]} ${post.documentID}");
        //             // return Text("hello");
        //             //  return workPost(
        //             //   userName: post["username"],
        //             //   userimage: post["userImageURL"],
        //             //   time: "5 min",
        //             //   postcontent: post["content"],
        //             //   // PostImg: post["postImageURL"],
        //             //   // likes: post["likes"],
        //             //   postID: post["postID"],
        //             //   userAbout: post["userAbout"]
        //             //   // functionalComment: true,
        //             //   );
        //           },
        //         );
        //         // return Text("HAHA");

        //         // return senderOrReceiver(message);
        //       }).toList(),
        //     );
        //   },
        // )

//         child: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection("Posts").snapshots(),
//         //       // .where("subspace", isEqualTo: "work")
//         //       .snapshots(),
//           builder: (context,AsyncSnapshot snapshot1) {
//         return StreamBuilder(
//         stream: FirebaseFirestore.instance.collection("UserData").snapshots(),
//       builder: (context, AsyncSnapshot snapshot2) {
//         // print(widget.chatID);
//             if (snapshot1.connectionState == ConnectionState.waiting) {
//               return SizedBox(
//                 height: MediaQuery.of(context).size.height / 1.3,
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             }
//             if (snapshot1.hasError) {
//               return Text("Something went wrong");
//             }
//             return ListView(
//               // shrinkWrap: true,
//               children:
//                   snapshot1.data.docs.map<Widget>((DocumentSnapshot document) {
//                 Map<String, dynamic> post =
//                     document.data() as Map<String, dynamic>;
//                 // return Text("HAHA");
//                 return workPost(
//                     userName: post["username"],
//                     userimage: post["userImageURL"],
//                     time: "5 min",
//                     postcontent: post["content"],
//                     // PostImg: post["postImageURL"],
//                     // likes: post["likes"],
//                     postID: post["postID"],
//                     userAbout: post["userAbout"]
//                     // functionalComment: true,
//                     );
//                 // return senderOrReceiver(message);
//               }).toList(),
//             );
//         // do some stuff with both streams here
//       },
//     );
//   },
// )

        child: FutureBuilder(
            future: completePost(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final posts = snapshot.data;
              return ListView(
                children: <Widget>[
                  for (var post in posts)
                    if (post["subspace"] ==
                        "work") // displaying in find work ////////////////////////////
                      workPost(
                          userName: post["username"],
                          userimage: post["userImageURL"],
                          time: post["created_at"],
                          postcontent: post["content"],
                          // PostImg: post["postImageURL"],
                          // likes: post["likes"],
                          postID: post["postID"],
                          userAbout: post["userAbout"]
                          // functionalComment: true,
                          ),
                ],
              );
            }),

        // ListView(
        //   children: [
        //     Post(
        //         userName: "Bill Gates",
        //         userimage: "assets/images/bill-gates.jpg",
        //         time: "3 min",
        //         postcontent: "new cmd lie fsgd nf odfg iajfd htr ghfh",
        //         postID: "xyz"),
        //   ],
        // )

        // ,
        // Text('Hello World'),
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
      margin: EdgeInsets.only(top: 10,),
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
          // PostFooter(
          //   likes: likes,
          //   post_id: postID,
          //   userName: userName,
          //   userimage: userimage,
          //   time: time,
          //   PostImg: PostImg,
          //   postcontent: postcontent,
          //   functionalComment: functionalComment,
          // ),
        ],
      ),
    );
  }
}


// Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>GetAllPostsContent() async {
//   var posts = await FirebaseFirestore.instance.collection("Posts").get();

//   return posts.docs;
// }


// completePost() async {
//   final posts = await GetAllPostsContent();
//   List<Map<String, dynamic>> completePosts = [];
//   for (var post in posts) {
//     final postWithUserData = await mapUserToPost(post);
//     completePosts.add(postWithUserData);
//   }
//   return completePosts;
// }

// mapUserToPost(post) async {
//   final userData = await getUserData(post["email"]);
//   Map<String, dynamic> postsMap = {
//     "username": userData.docs[0]["username"],
//     "userImageURL": userData.docs[0]["imageURL"],
//     "subspace": post["subspace"],
//     "content": post["content"],
//     "created_at": post["created_at"],
//     "email": post["email"],
//     "likes": post["likes"],
//     "postImageURL": post["imageURL"],
//     "postID": post.id
//   };
//   // print(post.id);
//   return postsMap;
// }

// getUserData(email) async {
//   return await FirebaseFirestore.instance
//       .collection("UserData")
//       .where("email", isEqualTo: email)
//       .get();
// }
