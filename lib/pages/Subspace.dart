import 'package:backspace/pages/Notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:backspace/pages/subspacechat.dart';
import 'package:backspace/pages/Instructor.dart';
import '../api/firebase-api.dart';
import 'NFeed.dart';

class SubSpace extends StatelessWidget {
  const SubSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Sub Space'),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: MyDelegate(
                          collection: "SubSpace",
                          fieldName: "name",
                          build: subspaceSearchBuilder),
                    );
                  },
                  icon: Icon(Icons.search, color: Colors.black))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: Icon(Icons.notifications_outlined),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //     child: Text("Joined Subspaces",
          //         textAlign: TextAlign.left,
          //         style: TextStyle(
          //           fontSize: 24,
          //         )),
          //     padding: EdgeInsets.only(top: 20, left: 10, bottom: 10)
          //     ),
          FutureBuilder(
              future: getallsubspaces(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.40),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final subspaces = snapshot.data;
                return ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    for (var each in subspaces)
                      // Text("data")
                      SimpleCard2(
                          userName: each["name"],
                          imagePath: each["imageURL"],
                          about: each["description"])
                  ],
                );
              }),

          // SimpleCard2(userName: "Gaming", imagePath: "/images/gaming.jpg"),
        ],
      ),
    );
  }
}

class SimpleCard2 extends StatelessWidget {
  final String? userName;
  final String? imagePath;
  final String? about;
  // final context;

  SimpleCard2({
    this.userName,
    this.imagePath,
    this.about,

    // required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubSpaceChat(
                      name: this.userName!,
                      image: this.imagePath!,
                      about: this.about!,
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
            ]),
            // elevation: 5,
          )),
    );
  }
}

getallsubspaces() async {
  var subspaces = await FirebaseFirestore.instance.collection("SubSpace").get();
  return subspaces.docs;
}

Widget subspaceSearchBuilder(collection, fieldName, query) {
  return FutureBuilder(
      future: FirebaseApi.searchCollection(collection, fieldName, query),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
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
        final subspaces = snapshot.data;
        return ListView(
          shrinkWrap: true,
          children: <Widget>[
            for (var each in subspaces)
              SimpleCard2(
                  userName: each["name"],
                  imagePath: each["imageURL"],
                  about: each["description"])
          ],
        );
      });
}
