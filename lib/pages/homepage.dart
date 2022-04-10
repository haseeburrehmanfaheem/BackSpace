// ignore_for_file: prefer_const_constructors

import 'package:backspace/pages/login.dart';
import 'package:backspace/pages/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

Widget buildAuthScreen() {
  return const Text("Authenticated");
}

class BuildUnauthScreen extends StatefulWidget {
  BuildUnauthScreen({Key? key}) : super(key: key);

  @override
  State<BuildUnauthScreen> createState() => _BuildUnauthScreenState();
}

class _BuildUnauthScreenState extends State<BuildUnauthScreen> {
  @override
  Widget build(BuildContext context) {
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
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Login()));
                  //   _navigateToNextScreen();
                },
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
                // onTap: () => print("hello world"),
                onTap: () {
                  // print("Container clicked");
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SignupPage()));
                },
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
}

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('New Screen')),
//       body: Center(
//         child: Text(
//           'This is a new screen',
//           style: TextStyle(fontSize: 24.0),
//         ),
//       ),
//     );
//   }
// }

class _HomeState extends State<Home> {
  @override
  bool isauth = false;
  Widget build(BuildContext context) {
    return isauth ? buildAuthScreen() : BuildUnauthScreen();
  }
}
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
