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
    .collection('UserData'); //database reference object

class Instructor extends StatelessWidget {
  const Instructor({Key? key}) : super(key: key);

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
          Padding(padding: EdgeInsets.only(top: 20.0)),
          ProfileWidget(), 
          const SizedBox(height: 24),
          buildName(),
          Center( child: Rating(initialRating: 4), ),
          // Rating(initialRating: 4),
          Review(),
          Review(),
          Review(),
          
        ], 
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add onPressed code here!
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.grey,
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
          // Text(
          //   user.email,
          //   style: TextStyle(color: Colors.grey),
          // )
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

class Review extends StatefulWidget{

  @override
  _Review createState() => _Review();

}


class _Review extends State <Review> {

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const UserIconName(
            userImage: DemoValues.userImage,
            username: DemoValues.userName,
            postTime: DemoValues.postTime,
          ),
          const PostBody(postSummary: DemoValues.postSummary),
        ],
      ),
    );
  }
}

class Rating extends StatelessWidget {
  final double initialRating;

  const Rating({required this.initialRating});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: RatingBar.builder(
          initialRating: initialRating,
          minRating: 1,
          itemSize: 25,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          ignoreGestures: true,
          onRatingUpdate: (rating) {},
        ));
  }
}






























