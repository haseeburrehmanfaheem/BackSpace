// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

Widget buildAuthScreen() {
  return const Text("Authenticated");
}

Scaffold BuildUnauthScreen() {
  return Scaffold(
    body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   "BackSpace",
            //   style: TextStyle(
            //     fontSize: 60.0,
            //     color: Colors.black,
            //   ),
            // )
            Container(
              height: 360.0,
              width: 360.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Logo.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            ),
            GestureDetector(
              child: Container(
                width: 380,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/widgets/loginbutton.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () => print("hello world"),
              child: Container(
                width: 380,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/widgets/signupbutton.png'),
                      fit: BoxFit.fill),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class _HomeState extends State<Home> {
  @override
  bool isauth = false;
  Widget build(BuildContext contxt) {
    return isauth ? buildAuthScreen() : BuildUnauthScreen();
  }
}
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }