import 'package:flutter/material.dart';
import 'dart:io';

import 'package:backspace/pages/Notification.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:backspace/helper/demo_values.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../components/newsFeed/post-body/posts-text.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';


class Guide extends StatelessWidget {
  const Guide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: const Text('Freshman Guide',
              style: TextStyle(fontFamily: "Poppins")),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: const Center(
          child: PostCard(),
        ),
      ),
    );
  }
}


class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6 / 3,
      child: Card(
        elevation: 2,
        child: Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              _Post(),
              Divider(color: Colors.grey),
              // _PostDetails(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Post extends StatelessWidget {
  const _Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(children: <Widget>[_PostImage(), Padding(padding:const EdgeInsets.only(left: 6.0) ,), _PostTitleAndSummary()]),
    );
  }
}

class _PostTitleAndSummary extends StatelessWidget {
  const _PostTitleAndSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final TextStyle titleTheme = Theme.of(context).textTheme.title;
    // final TextStyle summaryTheme = Theme.of(context).textTheme.body1;
    final String title = DemoValues.postTitle;
    final String summary = DemoValues.postSummary;
    final String username = DemoValues.userName;

    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Padding(padding: const EdgeInsets.only(left: 4.0),),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            SizedBox(height: 2.0),
            Text(summary, style: TextStyle(fontFamily: "Poppins")),
            Text(username, style: TextStyle(fontFamily: "Poppins", color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  const _PostImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 3, child: Image.asset(DemoValues.postImage));
  }
}

