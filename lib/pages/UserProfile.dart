import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:backspace/pages/Notification.dart';
import 'package:backspace/pages/add-post.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:backspace/helper/demo_values.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../components/newsFeed/post-body/posts-text.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';

final usersRef = FirebaseFirestore.instance
    .collection('UserData');


class UserProfile extends StatelessWidget {
  const UserProfile ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              padding: EdgeInsets.symmetric(horizontal: 24),
              // child: IconButton(
              //     onPressed: () {
              //       showSearch(
              //         context: context,
              //         delegate: MyDelegate(),
              //       );
              //       // Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(builder: (context) => const Noti()),
              //       // );
              //     },
              //     icon: Icon(Icons.search, color: Colors.black)
              //     )
                  ),
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
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [ 
          Padding(padding: EdgeInsets.all(20.0)),
          ProfileWidget(), 
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 15),
          Center(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children :[
                ElevatedButton.icon(
              onPressed: () {},
              label: const Text('Message',),
              icon: const Icon(Icons.message, size: 15,),
              style: ElevatedButton.styleFrom(
              primary: Colors.grey),
              ),
              ],
            ),
          
          ),
          Padding(
    
          padding: EdgeInsets.only(left:20, top: 10),
          child : const Text('About', style: TextStyle(fontSize: 20),),
          ),
          const PostBody(postSummary: DemoValues.postSummary),
          
          
        ], 
      ),
    );
  }



  Widget buildName() => Column(
        children: [
          Text(
            'Sir Barff',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
        ],
      );


}

class ProfileWidget extends StatefulWidget{

  @override 
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State <ProfileWidget>{


  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          
          buildImage(),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage("assets/images/bill-gates.jpg");

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          // child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}



