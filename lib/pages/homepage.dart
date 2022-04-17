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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                          Navigator.push(
                            context, MaterialPageRoute(builder: (_) => Login()));
                    },
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (_) => SignupPage()));
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(color: Colors. black)),
                    child: const Text(
                      "SIGN  UP",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class _HomeState extends State<Home> {
  @override
  bool isauth = false;
  Widget build(BuildContext context) {
    return isauth ? buildAuthScreen() : BuildUnauthScreen();
  }
}

