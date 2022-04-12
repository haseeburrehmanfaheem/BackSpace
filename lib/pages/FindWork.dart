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
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Find Work', style: TextStyle(fontFamily: "Poppins")),
        actions: [
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
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
                        time: "5 min",
                        postcontent: post["content"],
                        // PostImg: post["postImageURL"],
                        // likes: post["likes"],
                        postID: post["postID"],
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
  final String time;
  // final String? PostImg;
  final String postcontent;
  // final int likes;
  final String postID;
  // final bool functionalComment;

  const workPost({
    required this.userName,
    required this.userimage,
    required this.time,
    // this.PostImg,
    required this.postcontent,
    // required this.likes,
    required this.postID,
    // required this.functionalComment
  });

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
