import 'package:firebase_auth/firebase_auth.dart';
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
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: 
            [
            PostCard(Username: DemoValues.userName2, Title: DemoValues.postTitle2, Summary: DemoValues.postSummary2, PostDetails: DemoValues.postdetail, PostImage: DemoValues.postImage2,),
            PostCard(Username: DemoValues.userName3, Title: DemoValues.postTitle3, Summary: DemoValues.postSummary3, PostDetails: DemoValues.postdetail2, PostImage: DemoValues.postImage3,),
            PostCard(Username: DemoValues.userName4, Title: DemoValues.postTitle4, Summary: DemoValues.postSummary4, PostDetails: DemoValues.postdetail3, PostImage: DemoValues.postImage4,),
            ],
          ), 
        ),
      );
  }
}


class PostCard extends StatelessWidget {
  final String Title;
  final String Username;
  final String Summary;
  final String PostDetails;
  final String PostImage;


  const PostCard({
  required this.Title,
  required this.Username,
  required this.Summary,
  required this.PostDetails,
  required this.PostImage,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 8 / 3,
      child: InkWell(
      child: Card(
        elevation: 2,
        child: Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              _Post(username: Username, title: Title, summary: Summary, postDetails: PostDetails, postImage: PostImage,),
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ArticlePost(title: Title, postDetails: PostDetails, PostImage: PostImage, username: Username,)));
      },
      ),
    );
  }
}

class _Post extends StatelessWidget {
  final String title;
  final String username;
  final String summary;
  final String postDetails;
  final String postImage;

  const _Post({
  required this.title,
  required this.username,
  required this.summary,
  required this.postDetails,
  required this.postImage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(children: <Widget>[_PostImage(postImage1: postImage, ), Padding(padding:const EdgeInsets.only(left: 6.0) ,), _PostTitleAndSummary(Username1: username, Title1: title, Summary1: summary, PostDetails1: postDetails, )]),
    );
  }
}

class _PostTitleAndSummary extends StatelessWidget {
  // const _PostTitleAndSummary({Key? key}) : super(key: key);final String Title;
  final String Title1;
  final String Username1;
  final String Summary1;
  final String PostDetails1;



  const _PostTitleAndSummary({
  required this.Title1,
  required this.Username1,
  required this.Summary1,
  required this.PostDetails1,

  });

  @override
  Widget build(BuildContext context) {
    // final TextStyle titleTheme = Theme.of(context).textTheme.title;
    // final TextStyle summaryTheme = Theme.of(context).textTheme.body1;
    // final String title = DemoValues.postTitle;
    // final String summary = DemoValues.postSummary;
    // final String username = DemoValues.userName;

    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Padding(padding: const EdgeInsets.only(left: 4.0),),
            Text(Title1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 5.0),
            Text(Summary1, style: TextStyle(fontFamily: "Poppins")),
             SizedBox(height: 3.0),
            Text(Username1, style: TextStyle(fontFamily: "Poppins", color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  final String postImage1;

  const _PostImage({
  required this.postImage1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 3, child: Image.asset(postImage1));
  }
}




class ArticlePost extends StatelessWidget {
  final String title;
  final String postDetails;
  final String PostImage;
  final String username;


  const ArticlePost({
  required this.title,
  required this.postDetails,
  required this.PostImage,
  required this.username,
  });

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
          body: 
          SingleChildScrollView(child: 
          TextArticle(title1: title, postDetails1: postDetails, PostImages: PostImage, username1: username,)
          
          ),
          ),
    );
  }
}

class TextArticle extends StatelessWidget {
  final String postDetails1;
  final String PostImages;
  final String title1;
  final String username1;


  const TextArticle({
  required this.title1,
  required this.postDetails1,
  required this.PostImages,
  required this.username1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 24, top: 44),
          child: Text(
            title1 ,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, top: 15),
          child: Text(
            username1, style: TextStyle(fontFamily: "Poppins", color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 13)
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(
            postDetails1,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff79747E)),
          ),
        ),
        ArticleImage(postImage2: PostImages),
      ],
    );
  }
}


class ArticleImage extends StatelessWidget {
  final String postImage2;

  const ArticleImage({
  required this.postImage2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.only(left: 24, top: 24, right: 24),
          child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Expanded(flex: 3, child: Image.asset(postImage2)),
    ],
    ),
    );
  }
}
