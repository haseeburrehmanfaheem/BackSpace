// ignore_for_file: use_key_in_widget_constructors

import 'package:backspace/pages/Notification.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Instructors extends StatelessWidget {
  const Instructors({Key? key}) : super(key: key);

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
        title: const Text('Instructors Review',
            style: TextStyle(fontFamily: "Poppins")),
        actions: [
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Icon(Icons.search, color: Colors.black)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
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
      body:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        Padding(
            child: Text("Search Results",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                )),
            padding: EdgeInsets.only(top: 20, left: 10, bottom: 10)),
        SimpleCard(
            userName: "Bill Gates",
            imagePath: "assets/images/bill-gates.jpg",
            rating: Rating(initialRating: 3.5)),
        SimpleCard(
            userName: "Wajih Hassan",
            imagePath: "assets/images/user1jpg.jpg",
            rating: Rating(initialRating: 4.0)),
        SimpleCard(
            userName: "Zartash Uzmi",
            imagePath: "assets/images/user2.jpg",
            rating: Rating(initialRating: 3.5)),
      ]),
    );
  }
}

class SimpleCard extends StatelessWidget {
  final String userName;
  final String imagePath;
  final Widget? rating;

  const SimpleCard({
    required this.userName,
    required this.imagePath,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: Card(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            side:
                BorderSide(color: Color.fromARGB(101, 24, 21, 21), width: 0.5),
          ),
          child: Row(children: [
            ImageAndName(name: userName, image: imagePath),
            if (rating != null) rating!
          ]),
          // elevation: 5,
        ));
  }
}

class ImageAndName extends StatelessWidget {
  final String name;
  final String image;

  const ImageAndName({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        leading: CircleAvatar(radius: 30, backgroundImage: AssetImage(image)),
        title: Text(name,
            style: const TextStyle(
                fontFamily: "Poppins", fontSize: 18, letterSpacing: 0.2)),
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
