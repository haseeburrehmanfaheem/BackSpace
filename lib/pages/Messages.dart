// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';
import 'package:backspace/api/firebase-api.dart';
import 'package:backspace/components/newsFeed/post-header/user-icon-name.dart';
import 'package:backspace/pages/Chat.dart';
import 'package:backspace/pages/Notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/newsfeed.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';
import 'package:lit_relative_date_time/lit_relative_date_time.dart';

class Messages extends StatefulWidget {
  Messages({Key? key}) : super(key: key);
  // ignore: avoid_init_to_null
  List<Map<String, dynamic>>? searchResultUsers = [];
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final _formKey = GlobalKey<FormState>();
  String searchUsed = "";
  final TextEditingController userSearchController = TextEditingController();

  Widget userSearchFormWidget() {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: userSearchController,
        onChanged: (text) {
          if (text == "") {
            searchUsed = "";
            widget.searchResultUsers = [];
            setState(() => {});
          }
        },
        validator: (value) {
          return (value == null || value.isEmpty)
              ? 'Please enter some text'
              : null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          hintText: "Search Users",
          fillColor: Colors.grey.withOpacity(0.2),
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          suffixIcon: IconButton(
            icon: Icon(Icons.search_outlined),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                List<Map<String, dynamic>>? filteredUsers =
                    // await FirebaseApi.returnAllUsers();
                    await FirebaseApi.searchCollection(
                  "UserData",
                  "username",
                  userSearchController.text,
                );
                searchUsed = "search";
                setState(() => widget.searchResultUsers = filteredUsers);
              }
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            // bord

            // borderSide: BorderSide(color: Colors.white)
          ),
        ),
      ),
    );
  }

  Widget showSearchResults() {
    return widget.searchResultUsers != null
        ? widget.searchResultUsers!
                .isEmpty /* Case where No users match Search Query */
            ? Column(
                children: const [
                  SizedBox(height: 100),
                  Center(
                    child: Text("No Results Found",
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  )
                ],
              )
            : ListView(
                /* When results found for Search Query*/
                children: [
                  for (var user in widget.searchResultUsers!)
                    Message(
                      user: user,
                      posttext: "",
                    ),
                ],
              )
        : Text("Something Went Wrong!",
            /* When some error occurs while fetching results from firebase. */
            style: TextStyle(fontSize: 20, color: Colors.black));
  }

  showAllUsers() async {
    return FutureBuilder(
        future: FirebaseApi.returnAllUsers(),
        builder: (BuildContext context, AsyncSnapshot? snapshot) {
          if (snapshot != null) {
            return ListView(
              children: [
                for (var user in snapshot.data)
                  Message(
                    user: user,
                    posttext: "",
                  )
              ],
            );
          } else {
            return Text("");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: userSearchFormWidget(),
        actions: const [
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: searchUsed == ""
          ? StreamBuilder(
              stream: CombineLatestStream.list(
                [
                  FirebaseFirestore.instance
                      .collection('chat')
                      .where("user1",
                          isEqualTo: FirebaseAuth.instance.currentUser?.email)
                      .snapshots(),
                  FirebaseFirestore.instance
                      .collection('chat')
                      .where("user2",
                          isEqualTo: FirebaseAuth.instance.currentUser?.email)
                      .snapshots(),
                ],
              ),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // print(snapshot.data.docs);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot != null) {
                  return ListView(children: [
                    ...snapshot.data[0].docs
                        .map<Widget>((DocumentSnapshot document) {
                      Map<String, dynamic> chat =
                          document.data()! as Map<String, dynamic>;
                      return FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("UserData")
                              .where("email",
                                  isEqualTo: chat["user1"] ==
                                          FirebaseAuth
                                              .instance.currentUser?.email
                                      ? chat["user2"]
                                      : chat["user1"])
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot usersSnapshot) {
                            if (usersSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.3,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            if (usersSnapshot.hasError) {
                              return Text("Something went wrong");
                            }
                            final user = usersSnapshot.data.docs[0].data();
                            return Message(
                                user: user,
                                time: chat["last_message_time"],
                                posttext: chat["last_messsage"]);
                          });
                    }).toList(),
                    ...snapshot.data[1].docs
                        .map<Widget>((DocumentSnapshot document) {
                      Map<String, dynamic> chat =
                          document.data()! as Map<String, dynamic>;
                      return FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("UserData")
                              .where("email",
                                  isEqualTo: chat["user1"] ==
                                          FirebaseAuth
                                              .instance.currentUser?.email
                                      ? chat["user2"]
                                      : chat["user1"])
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot usersSnapshot) {
                            if (usersSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.3,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            if (usersSnapshot.hasError) {
                              return Text("Something went wrong");
                            }
                            final user = usersSnapshot.data.docs[0].data();
                            return Message(
                                user: user,
                                time: chat["last_message_time"],
                                posttext: chat["last_messsage"]);
                          });
                    }).toList(),
                  ]);
                } else {
                  return Text("");
                }
              })
          : showSearchResults(),
    );
  }
}

class Message extends StatelessWidget {
  final user;
  final Timestamp? time;
  final String posttext;
  // ignore: use_key_in_widget_constructors
  const Message({required this.user, this.time, required this.posttext});

  @override
  Widget build(BuildContext context) {
    RelativeDateTime _relativeDateTime;
    RelativeDateFormat _relativeDateFormatter;
    if (time != null) {
      RelativeDateTime _relativeDateTime = RelativeDateTime(
          dateTime: DateTime.now(),
          other: DateTime.parse(time!.toDate().toString()));

      RelativeDateFormat _relativeDateFormatter = RelativeDateFormat(
        Localizations.localeOf(context),
      );
    }
    return Container(
        //clipBehavior: Clip.antiAlias,
        child: Column(children: [
      const Padding(padding: EdgeInsets.only(top: 10, left: 0)),
      InkWell(
        onTap: () async {
          final currentUser = FirebaseAuth.instance.currentUser;
          final chatID =
              await FirebaseApi.getChatID(currentUser?.email, user["email"]);
          print("Look here $chatID");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(receiver: user, chatID: chatID)),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 10)),
                CircleAvatar(
                  backgroundImage: NetworkImage(user["imageURL"]),
                  radius: 30,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user["username"],
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(posttext,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                        ),
                      ],
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 15, top: 5),
              child: time != null
                  ? Text(
                      RelativeDateFormat(
                        Localizations.localeOf(context),
                      ).format(
                        RelativeDateTime(
                          dateTime: DateTime.now(),
                          other: DateTime.parse(
                            time!.toDate().toString(),
                          ),
                        ),
                      ),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    )
                  : Text(""),
            ),
          ],
        ),
      ),
      const Padding(padding: EdgeInsets.only(bottom: 10)),
      Divider(height: 1),
    ]));
    // elevation: 5,
    //)
  }
}
