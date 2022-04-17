import 'package:backspace/pages/Chat.dart';
import 'package:backspace/pages/Notification.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/newsfeed.dart';

import 'package:backspace/pages/Instructor.dart';

import 'NFeed.dart';

class SubSpaceChat extends StatelessWidget {
  final String name;
  final String image;
  final String about;

  const SubSpaceChat({
    required this.name,
    required this.image,
    required this.about,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text(name, style: TextStyle(fontFamily: "Poppins")),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
            child: Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 20)),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(image),
                ),
                Flexible(
                  child: ListTile(
                    title: Text(about,
                        style: TextStyle(fontSize: 18, letterSpacing: 0.2)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Simple(
                    title: name,
                    imagePath: image,
                    about: about,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AddSubspaceForm(
                postcontentController: addsubspacecontroller,
                hintText: "Send Message",
                subspaceName: name),
          ),
        ],
      ),
    );
    // ),
  }
}

var addsubspacecontroller = TextEditingController();

class Simple extends StatefulWidget {
  final String title;
  final String imagePath;
  final String about;
  // var selected;

  Simple({
    required this.title,
    required this.imagePath,
    required this.about,
    // this.selected
  });

  @override
  State<Simple> createState() => _SimpleState();
}

class _SimpleState extends State<Simple> {
  // var _selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(5),
      child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(
            //   height: 150,
            //   child: Row(
            //     children: [
            //       Padding(padding: EdgeInsets.only(left: 20)),
            //       CircleAvatar(
            //         radius: 50,
            //         backgroundImage: NetworkImage(widget.imagePath),
            //       ),
            //       Flexible(
            //         child: ListTile(
            //           title: Text(widget.about,
            //               style: TextStyle(fontSize: 18, letterSpacing: 0.2)),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Posts")
                  .where("subspace", isEqualTo: widget.title)
                  .orderBy('created_at', descending: false)
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
                  children: snapshot.data.docs
                      .map<Widget>((DocumentSnapshot document) {
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
                        return Sender1(
                          postText: post["content"],
                          userImage: snapshot1.data.docs[0]["imageURL"],
                        );

                        // Post(
                        //   userName: snapshot1.data.docs[0]["username"],
                        //   userimage: snapshot1.data.docs[0]["imageURL"],
                        //   time: "5 min",
                        //   postcontent: post["content"],
                        //   PostImg: post["imageURL"],
                        //   likes: post["likes"],
                        //   postID: document.id,
                        //   functionalComment: true,
                        //   userAbout: snapshot1.data.docs[0]["about"],
                        // );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ]),
    );
  }
}

class AddSubspaceForm extends StatefulWidget {
  final TextEditingController postcontentController;
  final String hintText;
  final String subspaceName;

  const AddSubspaceForm(
      {Key? key,
      required this.hintText,
      required this.postcontentController,
      required this.subspaceName})
      : super(key: key);

  @override
  AddPostFormState createState() => AddPostFormState();
}

class AddPostFormState extends State<AddSubspaceForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: Row(children: <Widget>[
          Expanded(
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: widget.postcontentController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  fillColor: const Color(0xfff9f9fa),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_outlined),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // print(widget.postcontentController.text);
                await SaveInSubspaceChat(
                    widget.postcontentController.text, widget.subspaceName);

                widget.postcontentController.clear();
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
          ),
        ]),
      ),
    );
  }
}

SaveInSubspaceChat(content, subspacename) async {
  var ref = await FirebaseFirestore.instance.collection("Posts");

  DateTime currentPhoneDate = DateTime.now(); //DateTime
  Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
  DateTime myDateTime = myTimeStamp.toDate();
  print(myDateTime);
  final users = await FirebaseAuth.instance.currentUser;
  String emailID = users!.email!;
  ref.add({
    "email": emailID,
    "imageURL": "",
    "content": content,
    "likes": 0,
    "created_at": myDateTime,
    "subspace": subspacename,
    "approved": true
  });
}

class Sender1 extends StatelessWidget {
  final String? userImage;
  final String postText;
  // ignore: use_key_in_widget_constructors
  const Sender1({required this.postText, required this.userImage});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5, left: 5),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(userImage!),
            ),
            BubbleSpecialThree(
              text: postText,
              color: Color(0xFFE8E8EE),
              tail: false,
              isSender: false,
            ),
          ],
        ));
  }
}


//  Align(
//               alignment: Alignment.bottomCenter,
//               child: AddSubspaceForm(
//                 postcontentController: addsubspacecontroller,
//                 hintText: "Send Message",
//                 subspaceName: widget.title,
//               ),
//             ),