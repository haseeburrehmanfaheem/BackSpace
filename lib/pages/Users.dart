// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Admindrawer.dart';

class Block extends StatelessWidget {
  const Block({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AdminDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Block Users'),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: Icon(Icons.search), onPressed: () {},
                // onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => Noti()),
                //   );
                // },
              ))
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("UserData")
            .where("roles", isEqualTo: "user")
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
          return ListView(
            children:
                snapshot.data.docs.map<Widget>((DocumentSnapshot document) {
              Map<String, dynamic> message =
                  document.data()! as Map<String, dynamic>;
              return BlockUser(
                  userImage: message["imageURL"],
                  username: message["username"],
                  blocked: message["blocked"],
                  email: message["email"]);
              // return senderOrReceiver(message);
            }).toList(),
          );
        },
      ),

      // ListView(children: [
      //   BlockUser(
      //       userImage: "assets/images/bill-gates.jpg",
      //       username: "Haseeb",
      //       blocked: true)
      // ]),
    );
  }
}

class BlockUser extends StatelessWidget {
  final String userImage;
  final bool blocked;
  final String username;
  final String email;

  // ignore: use_key_in_widget_constructors
  const BlockUser(
      {required this.userImage,
      required this.username,
      required this.blocked,
      required this.email});
  @override
  Widget build(BuildContext context) {
    if (blocked == false) {
      return Card(
          margin: EdgeInsets.zero,
          child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(userImage),
                ),
                title: Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(username,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ))

                    // Text(username, style: const TextStyle(fontWeight: FontWeight.w500)),
                    ),
                trailing: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: OutlinedButton(
                    //color: Colors.green,
                    child: Text(
                      "Block",
                      style: TextStyle(fontSize: 14.0, color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 1.0,
                        color: Colors.red,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () {
                      blockuserinDB(email, true);
                    },
                  ),
                ),
              )));
    } else {
      return Card(
          margin: EdgeInsets.zero,
          child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(userImage),
                ),
                title: Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(username,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ))

                    // Text(username, style: const TextStyle(fontWeight: FontWeight.w500)),
                    ),
                trailing: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: OutlinedButton(
                    //color: Colors.green,
                    child: Text(
                      "Unblock",
                      style: TextStyle(fontSize: 14.0, color: Colors.green),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 1.0,
                        color: Colors.green,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () {
                      blockuserinDB(email, false);
                    },
                  ),
                ),
              )));
    }
  }
}

blockuserinDB(email, blockkarna) async {
  var ref = await FirebaseFirestore.instance
      .collection("UserData")
      .where("email", isEqualTo: email)
      .get();

  ref.docs[0].reference.update({'blocked': blockkarna ? true : false});
}
