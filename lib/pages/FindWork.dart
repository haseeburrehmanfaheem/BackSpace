import 'package:backspace/pages/Notification.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/newsfeed.dart';

import '../components/newsFeed/post-body/posts-text.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';
import 'add-work.dart';

class FindWork extends StatelessWidget {
  const FindWork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //drawer: MyDrawer(),
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
      body:  Center(
        child: ListView(
          children : [
            Post(userName: "Bill Gates", userimage: "assets/images/bill-gates.jpg", time: "3 min", 
          postcontent: "new cmd lie fsgd nf odfg iajfd htr ghfh",
           postID: "xyz"),
           
          ]
        )
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



class Post extends StatelessWidget {
  final String userName;
  final String userimage;
  final String time;
  // final String? PostImg;
  final String postcontent;
  // final int likes;
  final String postID;
  // final bool functionalComment;

  const Post(
      {required this.userName,
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


