// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:backspace/pages/Notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/route_manager.dart';

import '../api/firebase-api.dart';
import 'InstructorProfile.dart';
import 'NFeed.dart';

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
        title: const Text('Instructors'),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: MyDelegate(
                          collection: "Instructor",
                          fieldName: "name",
                          build: instructorSearchBuilder),
                    );
                  },
                  icon: Icon(Icons.search, color: Colors.black))),
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
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Instructor").snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // print(widget.chatID);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
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
                children:
                    snapshot.data.docs.map<Widget>((DocumentSnapshot document) {
                  Map<String, dynamic> instructor =
                      document.data()! as Map<String, dynamic>;
                  return SimpleCard(
                    userName: instructor["name"],
                    imagePath: instructor["pictureURL"],
                    rating:
                        Rating(initialRating: instructor["rating"].toDouble()),
                    instructorID: instructor["id"],
                    initialRating: instructor["rating"].toDouble(),
                    // context:context ,
                  );
                  // return senderOrReceiver(message);
                }).toList(),
              );
            },
          )
          // Padding(
          //     // child: Text("Search Results",
          //     //     textAlign: TextAlign.left,
          //     //     style: TextStyle(
          //     //       fontSize: 24,
          //     //     )),
          //     padding: EdgeInsets.only(top: 20, left: 10, bottom: 10)),
          // FutureBuilder(
          //     future: getAllInstructors(),
          //     builder: (context, AsyncSnapshot snapshot) {
          //       if (!snapshot.hasData) {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //       final instructors = snapshot.data;
          //       return ListView(
          //         shrinkWrap: true,
          //         // ListView.builder(itemBuilder: itemBuilder)
          //         children: <Widget>[
          //           for (var instructor in instructors)
          //             SimpleCard(
          //               userName: instructor["name"],
          //               imagePath: instructor["pictureURL"],
          //               rating: Rating(
          //                   initialRating: instructor["rating"].toDouble()),
          //               instructorID: instructor["id"],
          //               initialRating: instructor["rating"].toDouble(),
          //               // context:context ,
          //             )
          //         ],
          //       );
          //     }),

          // SimpleCard(
          //     userName: "Bill Gates",
          //     imagePath: "assets/images/bill-gates.jpg",
          //     rating: Rating(initialRating: 3.5)),
          // SimpleCard(
          //     userName: "Wajih Hassan",
          //     imagePath: "assets/images/user1jpg.jpg",
          //     rating: Rating(initialRating: 4.0)),
          // SimpleCard(
          //     userName: "Zartash Uzmi",
          //     imagePath: "assets/images/user2.jpg",
          //     rating: Rating(initialRating: 3.5)),
        ],
      ),
    );
  }
}

class SimpleCard extends StatelessWidget {
  final String? userName;
  final String? imagePath;
  final Widget? rating;
  final initialRating;
  final String? instructorID;
  // final context;

  const SimpleCard({
    this.userName,
    this.imagePath,
    this.rating,
    this.instructorID,
    this.initialRating,
    // required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Instructor(
                      userName: userName,
                      imagePath: imagePath,
                      rating: rating,
                      instructorID: instructorID,
                      initialRating: initialRating,
                    )))
      },
      child: SizedBox(
          height: 80,
          child: Card(
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                  color: Color.fromARGB(101, 24, 21, 21), width: 0.5),
            ),
            child: Row(children: [
              ImageAndName(name: userName, image: imagePath),
              if (rating != null) rating!
            ]),
            // elevation: 5,
          )),
    );
  }
}

class ImageAndName extends StatelessWidget {
  final String? name;
  final String? image;

  const ImageAndName({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        leading:
            CircleAvatar(radius: 30, backgroundImage: NetworkImage(image!)),
        title: Text(name!,
            style: const TextStyle(fontSize: 18, letterSpacing: 0.2)),
      ),
    );
  }
}

class Rating extends StatelessWidget {
  final initialRating;

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

Widget instructorSearchBuilder(collection, fieldName, query) {
  return FutureBuilder(
    future: FirebaseApi.searchCollection(collection, fieldName, query),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (snapshot.hasError) {
        return Text("Something went wrong");
      }
      if (snapshot.data.isEmpty) {
        return Column(
          children: const [
            SizedBox(height: 100),
            Center(
              child: Text("No Results Found",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            )
          ],
        );
      }
      return ListView(
        shrinkWrap: true,
        children: snapshot.data.map<Widget>((instructor) {
          return SimpleCard(
            userName: instructor["name"],
            imagePath: instructor["pictureURL"],
            rating: Rating(initialRating: instructor["rating"].toDouble()),
            instructorID: instructor["id"],
            initialRating: instructor["rating"].toDouble(),
            // context:context ,
          );
          // return senderOrReceiver(message);
        }).toList(),
      );
    },
  );
}

getAllInstructors() async {
  var instructors = await FirebaseFirestore.instance
      .collection("Instructor")
      .orderBy('name', descending: false)
      .get();
  return instructors.docs;
}
