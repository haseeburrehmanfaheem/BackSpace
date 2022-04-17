// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:convert';

import 'package:backspace/pages/Messages.dart';
import 'package:backspace/pages/Notification.dart';
import 'package:backspace/pages/add-post.dart';
import 'package:backspace/pages/comments.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:backspace/helper/demo_values.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:sticky_float_button/sticky_float_button.dart';

import '../components/newsFeed/post-body/posts-text.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';

final usersRef = FirebaseFirestore.instance
    .collection('UserData'); //database reference object

class Feed extends StatelessWidget {
  // const Feed({Key? key}) : super(key: key);
  var posts;
  @override
  Widget build(BuildContext context) {
    List timelinePosts = [];

    return Scaffold(
      // GetAllPostsContent();
      backgroundColor: Color(0xffDADADA),
      drawer: const MyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('News Feed'),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: MyDelegate(),
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const Noti()),
                    // );
                  },
                  icon: Icon(Icons.search, color: Colors.black))),
          // Icon(Icons.search, color: Colors.black)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Noti()),
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
            .where("subspace", isEqualTo: "")
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
                  return Post(
                      userName: snapshot1.data.docs[0]["username"],
                      userimage: snapshot1.data.docs[0]["imageURL"],
                      time: post["created_at"],
                      postcontent: post["content"],
                      PostImg: post["imageURL"],
                      likes: post["likes"],
                      postID: document.id,
                      functionalComment: true,
                      userAbout: snapshot1.data.docs[0]["about"],
                      email: snapshot1.data.docs[0]["email"]);
                },
              );
            }).toList(),
          );
        },
      )

          // child: FutureBuilder(
          //     future: completePost(),
          //     builder: (context, AsyncSnapshot snapshot) {
          //       if (!snapshot.hasData) {
          //         return CircularProgressIndicator();
          //       }
          //       final posts = snapshot.data;
          //       return ListView(
          //         children: <Widget>[
          //           for (var post in posts)
          //             if ((post["subspace"] == null || post["subspace"] == "") &&
          //                 (post["approved"] ==
          //                     true)) // displaying in newsfeed ////////////////////////////
          //               Post(
          //                 userName: post["username"],
          //                 userimage: post["userImageURL"],
          //                 time: "5 min",
          //                 postcontent: post["content"],
          //                 PostImg: post["postImageURL"],
          //                 likes: post["likes"],
          //                 postID: post["postID"],
          //                 functionalComment: true,
          //                 userAbout: post["userAbout"],
          //               ),
          //         ],
          //       );
          //     }),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPostPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
    );
  }
}

// final databaseRef = FirebaseFirestore.instance.collection('UserData'); //database reference object
// Future<void> getData() async {
//     // Get docs from collection reference
//     QuerySnapshot querySnapshot = await databaseRef.get();

//     // Get data from docs and convert map to List
//     final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

//     print(allData);
// }

newPage(context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Noti()),
  );
}

class Post extends StatelessWidget {
  final String userName;
  final String userimage;
  final Timestamp time;
  final String? PostImg;
  final String postcontent;
  final int likes;
  final String postID;
  final bool functionalComment;
  final String userAbout;
  final String? email;

  const Post(
      {required this.userName,
      required this.userimage,
      required this.time,
      this.PostImg,
      required this.postcontent,
      required this.likes,
      required this.postID,
      required this.functionalComment,
      required this.userAbout,
      this.email});

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
            userabout: userAbout,
            delete: email,
            docid: postID,
          ),
          PostBody(postSummary: postcontent),
          if (PostImg != null && PostImg != "") Image.network(PostImg!),
          Divider(height: 1),
          PostFooter(
            likes: likes,
            post_id: postID,
            userName: userName,
            userimage: userimage,
            time: time,
            PostImg: PostImg,
            postcontent: postcontent,
            functionalComment: functionalComment,
          ),
        ],
      ),
    );
  }
}

final formGlobalKey = GlobalKey<FormState>();

// Display Like and Comment Post Footer Bar
class PostFooter extends StatefulWidget {
  int likes;
  var post_id;

  final String userName;
  final String userimage;
  final Timestamp time;
  final String? PostImg;
  final String postcontent;
  final bool functionalComment;
  // final int likes;
  // final String postID;
  PostFooter(
      {Key? key,
      required this.likes,
      required this.post_id,
      required this.userName,
      required this.userimage,
      required this.time,
      required this.PostImg,
      required this.postcontent,
      required this.functionalComment})
      : super(key: key);

  @override
  _PostFooter createState() => _PostFooter();
}

class _PostFooter extends State<PostFooter> {
  bool clicked_once = false;
  bool pressAttention = false;
  @override
  Widget build(BuildContext context) {
    var x = widget.likes;
    print(x);
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.thumb_up_alt_outlined),
          color: pressAttention ? Colors.blue : Colors.black,
          onPressed: () {
            clicked_once = !clicked_once;
            updatelikesintable(widget.likes, widget.post_id, !clicked_once);
            updateLikes();
          },
        ),
        Text(x.toString()),
        const Padding(padding: EdgeInsets.only(right: 70)),
        const Padding(padding: EdgeInsets.only(left: 70.0)),
        Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.comment),
              onPressed: () {
                if (widget.functionalComment) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Postscomment(
                              likes: widget.likes,
                              post_id: widget.post_id,
                              userName: widget.userName,
                              userimage: widget.userimage,
                              time: widget.time,
                              PostImg: widget.PostImg,
                              postcontent: widget.postcontent)));
                }
                //
                // print("Mustansar tatto");
                // pass
              },
            )),
        const Text('Comment', style: TextStyle(fontFamily: "Poppins")),
      ],
    );
  }

  updateLikes() {
    setState(() => {
          if (clicked_once)
            {widget.likes = widget.likes + 1, pressAttention = !pressAttention}
          else
            {widget.likes = widget.likes - 1, pressAttention = !pressAttention}
        });
  }
}

class Postscomment extends StatefulWidget {
  int likes;
  var post_id;
  final String userName;
  final String userimage;
  final Timestamp time;
  final String? PostImg;
  final String postcontent;
  Postscomment(
      {Key? key,
      required this.likes,
      required this.post_id,
      required this.userName,
      required this.userimage,
      required this.time,
      required this.PostImg,
      required this.postcontent})
      : super(key: key);
  // print()
  @override
  State<Postscomment> createState() => _PostscommentState();
}

class _PostscommentState extends State<Postscomment> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // print()
    return Scaffold(
      backgroundColor: Color(0xffDADADA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: const Text("Comments",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Post(
                    userName: widget.userName,
                    userimage: widget.userimage,
                    time: widget.time,
                    postcontent: widget.postcontent,
                    likes: widget.likes,
                    postID: widget.post_id,
                    PostImg: widget.PostImg,
                    functionalComment: false,
                    // IMPORTANT ___________________________________________________________________________________________
                    userAbout: "",
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  // CommentsDisplay(userImg: "assets/images/bill-gates.jpg", name: "Zeerak", Time: "2 sec", posttext: "Bhai SE ka kaam kab khatam hona? sdfsdf sfs sfsdfsfsfs  sdfdsfsfs sfsfsfsfs sfsfsfsfsfs"),
                  // DisplayComments(comments, profileImage, name),
                  FutureBuilder(
                      future: getAllComments(widget.post_id),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Text("");
                        }
                        final comments = snapshot.data;
                        return Column(
                          children: <Widget>[
                            for (var comment in comments)
                              CommentsDisplay(
                                  userImg: comment["userimageURL"],
                                  name: comment["username"],
                                  Time: "",
                                  posttext: comment["commentContent"])
                            // Text(comment["commentContent"]),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
          Container(
            // margin: EdgeInsets.all(),
            color: Colors.white,
            child: Form(
              key: formGlobalKey,
              child: Container(
                margin: EdgeInsets.all(15),
                child: TextFormField(
                  controller: commentController,
                  onTap: () {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter some Text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: "Add Comment",
                    fillColor: Colors.grey.withOpacity(0.2),
                    // fromRGBO(249, 249, 250, 1),

                    filled: true,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),

                    suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () async {
                        if (formGlobalKey.currentState!.validate()) {
                          // print(commentController.text);
                          await updateCommentInDB(
                              commentController.text, widget.post_id);
                          commentController.clear();
                          // Navigator.pushReplacement(context,Postscomment(likes: widget.likes, post_id: widget.post_id, userName: widget.userName, userimage: widget.userimage, time: widget.time, PostImg: widget.PostImg, postcontent: widget.postcontent))
                        }
                      },
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),

                      // borderSide: BorderSide(color: Colors.white)
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  updateCommentInDB(comment, postDocID) async {
    CollectionReference comments =
        await FirebaseFirestore.instance.collection('Comments');
    final user = await FirebaseAuth.instance.currentUser;
    String? user_email = await user!.email;
    CollectionReference user_table =
        await FirebaseFirestore.instance.collection('UserData');
    var userTable =
        await user_table.where("email", isEqualTo: user_email).get();
    var userImageURL = userTable.docs[0]["imageURL"];
    var userName = userTable.docs[0]["username"];

    // print(userName);
    // print(userImageURL);
    // print(comment);

    comments.add({
      "postId": postDocID,
      "username": userName,
      "userimageURL": userImageURL,
      "commentContent": comment,
    }).then((value) => setState(
          () => {},
        ));
    //   var ref = await FirebaseFirestore.instance
    //     .collection("UserData")
    //     .where("email", isEqualTo: email)
    //     .get();

    // var s = ref.docs[0];
    // return s;
  }
}

// class DisplayComments extends StatelessWidget {
//   const DisplayComments({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

updatelikesintable(likes, documentID, alreadyliked) {
  var posts = FirebaseFirestore.instance.collection('Posts');
  posts.doc(documentID) // <-- Doc ID where data should be updated.
      .update({'likes': alreadyliked ? likes - 1 : likes + 1}).then(
          (value) => {print('likes updated to ${likes + 1}')});
}

class AddPostForm extends StatefulWidget {
  final TextEditingController postcontentController;
  final Function? openPopup;
  final Function(File)? changeState;
  final Widget? sendButton;
  final String hintText;
  final bool showImagesIcons;

  const AddPostForm({
    Key? key,
    required this.showImagesIcons,
    required this.hintText,
    this.openPopup,
    this.changeState,
    this.sendButton,
    required this.postcontentController,
  }) : super(key: key);

  @override
  AddPostFormState createState() => AddPostFormState();
}

class AddPostFormState extends State<AddPostForm> {
  final _formKey = GlobalKey<FormState>();
  File? image;

  Future handleChoosefromgallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return false;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
      widget.changeState!(imageTemp);
      return true;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return false;
    }
  }

  Future handleTakephoto() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return false;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
      widget.changeState!(imageTemp);
      return true;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        //
        Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
            // mainAxisSize: MainAxisSize.min, // added line
            children: <Widget>[
              Expanded(
                // child: Container(
                  // color: Colors.white,
                  child: Form(
                    key: _formKey,
                    // child: Container(
                      //  margin: EdgeInsets.all(15),
                      child: TextFormField(
                        controller: widget.postcontentController,
                        onTap: () {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              ),
                          borderRadius: BorderRadius.circular(50.0),
                          ),
                          hintText: widget.hintText,
                          fillColor: Colors.grey.withOpacity(0.2),
                          filled: true,
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),

                      ),
                    ),
                  ),
                  // ),
                  // ),
                ),
              ),
              if (widget.showImagesIcons)
                IconButton(
                    onPressed: () async {
                      final success = await handleTakephoto();
                      if (widget.openPopup != null && success) {
                        widget.openPopup!();
                      }
                    }, //Open Camera here
                    icon: const Icon(Icons.camera_alt_outlined)),
              if (widget.showImagesIcons)
                IconButton(
                    onPressed: () async {
                      final success = await handleChoosefromgallery();
                      if (widget.openPopup != null && success) {
                        // print('OpenPopup');
                        widget.openPopup!();
                      }
                    }, //Open Gallery here
                    icon: const Icon(Icons.photo)),
              if (widget.sendButton != null) widget.sendButton!,
            ]),
      ),
    );
  }
}

class MyDelegate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
              // query = '';
            },
            icon: Icon(Icons.clear))
      ];

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      );
  // TODO: implement buildResults
  // throw UnimplementedError();

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [
      // 'Zeerak1',
      // 'Zeerak2',
      // 'Zeerak3',
      // 'Zeerak4',
    ];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final sug = suggestions[index];
        return ListTile(
          title: Text(sug),
          onTap: () {
            query = sug;
            showResults(context);
          },
        );
      },
    );
    // TODO: implement buildSuggestions
    // throw UnimplementedError();
  }
}

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
    GetAllPostsContent() async {
  var posts = await FirebaseFirestore.instance
      .collection("Posts")
      .orderBy('created_at', descending: true)
      // .where("approved", isEqualTo: true)
      .get();

  return posts.docs;
}

getAllComments(doc_id) async {
  var comments = await FirebaseFirestore.instance
      .collection("Comments")
      .where("postId", isEqualTo: doc_id)
      .get();
  // ?;
  // print(comments)
  // print(comments.docs[0]["commentContent"]);
  return comments.docs;
}

completePost() async {
  final posts = await GetAllPostsContent();
  List<Map<String, dynamic>> completePosts = [];
  for (var post in posts) {
    final postWithUserData = await mapUserToPost(post);
    completePosts.add(postWithUserData);
  }
  return completePosts;
}

mapUserToPost(post) async {
  final userData = await getUserData(post["email"]);
  Map<String, dynamic> postsMap = {
    "username": userData.docs[0]["username"],
    "userImageURL": userData.docs[0]["imageURL"],
    "subspace": post["subspace"],
    "content": post["content"],
    "created_at": post["created_at"],
    "email": post["email"],
    "likes": post["likes"],
    "postImageURL": post["imageURL"],
    "postID": post.id,
    "userAbout": userData.docs[0]["about"],
    "approved": post["approved"]
  };
  // print(post.id);
  return postsMap;
}

getUserData(email) async {
  return await FirebaseFirestore.instance
      .collection("UserData")
      .where("email", isEqualTo: email)
      .get();
}

NameImage(email) async {
  var posts = await FirebaseFirestore.instance
      .collection("UserData")
      .where("email", isEqualTo: email)
      .get();
  String s = posts.docs[0]["username"];
  String d = posts.docs[0]["imageURL"];
  return [posts.docs[0]["username"], posts.docs[0]["imageURL"]];
}

//row user future post call
//


