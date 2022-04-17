import 'package:backspace/pages/Notification.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/newsfeed.dart';

import 'package:backspace/pages/Instructor.dart';

class SubSpaceChat extends StatelessWidget {
  final String name;
  final String image;
  final String about;

  const SubSpaceChat({
  required this.name,
  required this.image,
  required this.about,
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
            title: Text( name,
              style: TextStyle(fontFamily: "Poppins")),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          body: 
          SingleChildScrollView(child: 
          Simple(userName: about, imagePath: image,),
          
          
          ),
          ),
    );
  }
}




class Simple extends StatelessWidget {
  final String userName;
  final String imagePath;

  const Simple({
    required this.userName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
    SizedBox(
        height: 150,
        child:  Row(

          children: [
            Padding(padding: EdgeInsets.only(left: 20)),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/sophia_hs.jpg'),
            ),
            Flexible(
              child: ListTile(
                title: Text(
                  "ABout asdhasdlbcjaksfkldjcaksnfvajdnfuvndifunvil",
                  style: TextStyle(
                fontFamily: "Poppins", fontSize: 18, letterSpacing: 0.2)
                ),
                ),
              ),
            
          ],
        ),
    ),
    Divider(color: Colors.grey),
    // Container(
    //           alignment: Alignment.bottomCenter,
    //           width: MediaQuery.of(context).size.width,
    //           child: Container(
    //             padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    //             color: Colors.grey[100],
    //             child: Row(
    //               children: <Widget>[
    //                 Expanded(
    //                   child: TextField(
    //                     // controller: messageEditingController,
    //                     style: TextStyle(
    //                       color: Colors.black
    //                     ),
    //                     decoration: InputDecoration(
    //                       hintText: "Send a message ...",
    //                       hintStyle: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 16,
    //                       ),
    //                       border: InputBorder.none
    //                     ),
    //                   ),
    //                 ),
                     
    //               ],
    //             ),
    //           ),

            // ),

    ]
    ); 
  }
}

