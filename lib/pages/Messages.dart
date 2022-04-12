// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:backspace/api/firebase-api.dart';
import 'package:backspace/components/newsFeed/post-header/user-icon-name.dart';
import 'package:backspace/pages/Notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/newsfeed.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';

class Messages extends StatefulWidget {
  Messages({Key? key}) : super(key: key);
  List<Map<String, dynamic>>? searchResultUsers = [];
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userSearchController = TextEditingController();

  Widget userSearchFormWidget() {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: userSearchController,
        validator: (value) {
          return (value == null || value.isEmpty)
              ? 'Please enter some text'
              : null;
        },
        decoration: InputDecoration(
          hintText: "Add Post",
          fillColor: const Color(0xfff9f9fa),
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                List<Map<String, dynamic>>? filteredUsers =
                    await FirebaseApi.searchUsers(userSearchController.text);
                setState(() => widget.searchResultUsers = filteredUsers);
              }
            },
          ),
        ),
      ),
    );
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
      body: widget.searchResultUsers != null
          ? widget.searchResultUsers!.isEmpty
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
                  children: [
                    for (var user in widget.searchResultUsers!)
                      Message(
                        userImg: user["imageURL"],
                        name: user["username"],
                        Time: "2 sec",
                        posttext: "",
                      ),
                  ],
                )
          : Text("Something Went Wrong!",
              style: TextStyle(fontSize: 20, color: Colors.black)),
    );
  }
}

class Message extends StatelessWidget {
  final String userImg;
  final String Time;
  final String name;
  final String posttext;
  // ignore: use_key_in_widget_constructors
  const Message(
      {required this.userImg,
      required this.name,
      required this.Time,
      required this.posttext});
  @override
  Widget build(BuildContext context) {
    return Container(
        //clipBehavior: Clip.antiAlias,
        child: Column(children: [
      const Padding(padding: EdgeInsets.only(top: 10, left: 0)),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 10)),
                CircleAvatar(
                  backgroundImage: NetworkImage(userImg),
                  radius: 30,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        Text(posttext,
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 15, top: 5),
              child: Text(
                Time,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
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
