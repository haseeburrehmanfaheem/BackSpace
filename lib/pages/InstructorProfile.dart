// import 'dart:html';
// import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:backspace/pages/ViewProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:backspace/pages/Notification.dart';
import 'package:backspace/pages/add-post.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:backspace/helper/demo_values.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../components/newsFeed/post-body/posts-text.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';
// import 'smooth_star_rating_nsafe/smooth_star_rating.dart';

final usersRef = FirebaseFirestore.instance
    .collection('UserData'); //database reference object

class Instructor extends StatelessWidget {
  final String? userName;
  final String? imagePath;
  final Widget? rating;
  final String? instructorID;
  final initialRating;
  const Instructor({
    Key? key,
    this.userName,
    this.imagePath,
    this.rating,
    this.instructorID,
    this.initialRating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: const MyDrawer(),

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: const Text('Instructor Review'),
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
          ProfileWidget(
            url: imagePath!,
          ),
          const SizedBox(height: 24),
          buildName(userName),
          getRatingone(
            initialRating: initialRating,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("InstructorReview")
                .where("instructorID", isEqualTo: instructorID)
                .snapshots(),
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
              return Column(
                // shrinkWrap: true,
                children:
                    snapshot.data.docs.map<Widget>((DocumentSnapshot document) {
                  Map<String, dynamic> instructor =
                      document.data()! as Map<String, dynamic>;
                  return Review(
                    username: instructor["name"],
                    userimageURL: instructor["imageURL"],
                    Content: instructor["content"],
                    rating: instructor["rating"].toDouble(),
                  );
                  // return senderOrReceiver(message);
                }).toList(),
              );
            },
          )

          // FutureBuilder(
          //     future: getInstructorReview(instructorID),
          //     builder: (context, AsyncSnapshot snapshot) {
          //       if (!snapshot.hasData) {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //       final instructors = snapshot.data;
          //       return Column(
          //         // shrinkWrap: true,
          //         // ListView.builder(itemBuilder: itemBuilder)
          //         children: <Widget>[
          //           for (var instructor in instructors)
          //             Review(
          //               username: instructor["name"],
          //               userimageURL: instructor["imageURL"],
          //               Content: instructor["content"],
          //               rating: instructor["rating"].toDouble(),
          //             )
          //         ],
          //       );
          //     }),
          // Center(
          //   child: Rating(initialRating: 4),
          //   ),
          // Rating(initialRating: 4),
          // Review(),
          // Review(),
          // Review(),
          // Review()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddReview(
                      instructorID: instructorID!,
                    )),
          );
          AddReviewForm(
            instructorID: instructorID!,
          );
          // Add onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
    );
  }

  Widget buildName(name) => Column(
        children: [
          Text(
            name,
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

final textformkey = GlobalKey<FormState>();

class AddReview extends StatelessWidget {
  String instructorID;
  AddReview({Key? key, required this.instructorID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        title: const Text('Add Review'),
        actions: [
          // Icon(Icons.search, color: Colors.black)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: MaterialButton(
              onPressed: () {
                if (textformkey.currentState!.validate()) {
                  // print(reviewcontentController.text);
                  // print(inputRating);
                  // print(instructorID);
                  addInstructorReviewinDB(
                      reviewcontentController.text, inputRating, instructorID);
                  UpdateAverageRating(instructorID);
                  reviewcontentController.clear();
                  Navigator.pop(context);
                  // navigator.pu
                  // Navigator.pushReplacement(context, newRoute)
                }
              },
              // if()
              //   if (_formKey.currentState!.validate()) {

              // },
              child: const Text(
                "Post",
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Stack(children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Container(),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AddstarsForm(),
                AddReviewForm(),
              ],
            )

            // set
            // Text("xx"),
            // AddWorkForm(
            // workcontentController: workcontentController,
            // changeState: changeState,
            // ),
            ),
      ]),
    );
  }
}

var inputRating = 5.0;

class AddstarsForm extends StatelessWidget {
  AddstarsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RatingBar.builder(
        initialRating: 5,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        // ignoreGestures: true,
        onRatingUpdate: (rating) {
          inputRating = rating;
          // print(inputRating);
        },
      ),
    );
  }
}

var reviewcontentController = TextEditingController();

class AddReviewForm extends StatelessWidget {
  final String? instructorID;
  AddReviewForm({Key? key, this.instructorID}) : super(key: key);
  @override
  // final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: Row(children: <Widget>[
          Expanded(
            child: Form(
              key: textformkey,
              child: TextFormField(
                controller: reviewcontentController,
                onTap: () {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Review before proceeding';
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
                  hintText: "Add Review",
                  fillColor: Colors.grey.withOpacity(0.2),
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  String url;
  ProfileWidget({Key? key, required this.url}) : super(key: key);
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  // String url;
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
    final image = NetworkImage(widget.url);

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

class getRatingone extends StatelessWidget {
  final double initialRating;
  const getRatingone({required this.initialRating});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(initialRating.toString()),
        Rating(
          initialRating: initialRating,
          size: 25,
        ),
        // Text('(23 Reviews)'),
      ],
    );
  }
}

class getRatingtwo extends StatelessWidget {
  final double initialRating;
  const getRatingtwo({required this.initialRating});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(initialRating.toString()),
        Rating(
          initialRating: initialRating,
          size: 15,
        ),
      ],
    );
  }
}

class Review extends StatefulWidget {
  const Review(
      {Key? key,
      required this.username,
      required this.userimageURL,
      required this.Content,
      required this.rating})
      : super(key: key);

  final username;
  final userimageURL;
  final Content;
  final rating;

  @override
  _Review createState() => _Review();
}

class _Review extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          UserIcon(
            userImage: widget.userimageURL,
            username: widget.username,
            rating: widget.rating,
            // postTime: DemoValues.postTime,
          ),
          PostBody(postSummary: widget.Content),
        ],
      ),
    );
  }
}

class Rating extends StatelessWidget {
  final double initialRating;
  final double size;

  const Rating({required this.initialRating, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: RatingBar.builder(
        initialRating: initialRating,
        minRating: 1,
        itemSize: size,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        ignoreGestures: true,
        onRatingUpdate: (rating) {},
      ),
    );
  }
}

class UserIcon extends StatelessWidget {
  final String userImage;
  // final String postTime;
  final String username;
  var rating;
  // ignore: use_key_in_widget_constructors
  UserIcon({
    required this.userImage,
    required this.username,
    required this.rating,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(userImage)),
      title: Padding(
        padding: EdgeInsets.only(left: 5),
        child:
            Text(username, style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
      subtitle: getRatingtwo(
        initialRating: rating,
      ),
      trailing: Padding(
        padding: EdgeInsets.only(right: 15),
        // child: Text(
        //   postTime,
        //   style: const TextStyle(fontWeight: FontWeight.w500),
        // ),
      ),
    );
  }
}

addInstructorReviewinDB(content, rating, instructorID) async {
  var ref = await FirebaseFirestore.instance.collection("InstructorReview");
  final user = await FirebaseAuth.instance.currentUser;
  String? email = user?.email;

  var posts = await FirebaseFirestore.instance
      .collection("UserData")
      .where("email", isEqualTo: email)
      .get();
  var imageURL = posts.docs[0]["imageURL"];
  var name = posts.docs[0]["username"];
  // print(imageURL);

  ref
      .add({
        "name": name,
        "imageURL": imageURL,
        "content": content,
        "rating": rating,
        "instructorID": instructorID,
      })
      .then((value) async {})
      .catchError((error) => print("Failed to add user: $error"));
  return;
}

getInstructorReview(instructorID) async {
  var posts = await FirebaseFirestore.instance
      .collection("InstructorReview")
      .where("instructorID", isEqualTo: instructorID)
      .get();
  var docs = posts.docs;
  // print(docs[0]["content"]);

  return posts.docs;
}

UpdateAverageRating(instructorID) async {
  var posts = await FirebaseFirestore.instance
      .collection("InstructorReview")
      .where("instructorID", isEqualTo: instructorID)
      .get();

  var docs = posts.docs;

  double rating = 0.0;
  double total = 0;
  for (var each in docs) {
    total++;
    rating += each["rating"];
  }
  rating = rating / total * 1.0;
  print(rating);
  String inString = rating.toStringAsFixed(2);
  rating = double.parse(inString);

  // final user = FirebaseAuth.instance.currentUser;
  var ref = await FirebaseFirestore.instance
      .collection("Instructor")
      .where("id", isEqualTo: instructorID)
      .get();
  ref.docs[0].reference.update({"rating": rating});
}
