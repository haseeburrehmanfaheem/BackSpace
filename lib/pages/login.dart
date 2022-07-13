// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:backspace/pages/ApprovedPosts.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:backspace/pages/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: formkey,
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            // child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30, bottom: 10, top: 10),
                      child: Row(children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, bottom: 40),
                      child: Row(children: [
                        Text(
                          "Welcome back, login to continue",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.50),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: makeInput(
                                label: "Email",
                                icons: Icon(Icons.email, color: Colors.black),
                                controllerObj: emailController,
                                fk: formkey1),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 40,
                            ),
                            child: makeInput(
                                label: "Password",
                                icons: Icon(Icons.lock, color: Colors.black),
                                obsureText: true,
                                controllerObj: passwordController,
                                fk: formkey2),
                          )
                        ],
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
                            if (formkey1.currentState!.validate() &&
                                formkey2.currentState!.validate()) {
                              // showLoaderDialog(context);
                              login(emailController.text,
                                  passwordController.text, context);
                            }
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 35),
                          child: const Text("Don't have an account?"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignupPage()));
                          },
                          child: const Text('Sign up',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

login(emailAddress, password, context) async {
  try {
    showLoaderDialog(context);
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    final roles = await getUserData(emailAddress);
    final temp = roles.docs[0]["roles"];
    final blocked = roles.docs[0]["blocked"];
    // showLoaderDialog(context);
    if (temp == "user") {
      // showLoaderDialog(context);
      if (blocked) {
        Fluttertoast.showToast(
            msg: "The User is blocked", gravity: ToastGravity.TOP);
      } else {
        // showLoaderDialog(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => BottomNavigation()));
      }
    } else if (temp == "admin") {
      // showLoaderDialog(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Proved()));
    }
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (_) => BottomNavigation()));
    print('The user has been logged in');
    print(temp);
  } on FirebaseAuthException catch (e) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
    if (e.code == 'user-not-found') {
      Fluttertoast.showToast(
          msg: "These credentials do not match our records",
          gravity: ToastGravity.TOP);
    } else if (e.code == 'wrong-password') {
      Fluttertoast.showToast(
          msg: "These credentials do not match our records.",
          gravity: ToastGravity.TOP);
    }
  }
}

getUserData(email) async {
  return await FirebaseFirestore.instance
      .collection("UserData")
      .where("email", isEqualTo: email)
      .get();
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
