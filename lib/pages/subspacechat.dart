// import 'package:backspace/pages/Notification.dart';
// import 'package:flutter/material.dart';
// import 'package:backspace/pages/newsfeed.dart';

// import 'package:backspace/pages/Instructor.dart';

// class SubSpaceChat extends StatelessWidget {
//   final String name;
//   final String image;
//   final String about;

//   const SubSpaceChat({
//     required this.name,
//     required this.image,
//     required this.about,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.chevron_left),
//           onPressed: () => Navigator.pop(context, false),
//         ),
//         title: Text(name),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         child: TopCard(
//           userName: about,
//           imagePath: image,
//         ),
//       ),
//     );
//   }
// }

// class TopCard extends StatelessWidget {
//   final String userName;
//   final String imagePath;

//   const TopCard({
//     required this.userName,
//     required this.imagePath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.zero,
//       shape: const RoundedRectangleBorder(
//         side: BorderSide(color: Color.fromARGB(101, 24, 21, 21), width: 0.5),
//       ),
//       child: Row(children: [
//         ImageAndName(name: userName, image: imagePath),
//       ]),
//       // elevation: 5,
//     );
//   }
// }
