// import 'dart:html';

import 'package:backspace/Services/AuthenticationServices.dart';
import 'package:backspace/model/errors.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';

class SignupPage extends StatelessWidget {
  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formkey3 = GlobalKey<FormState>();
  GlobalKey<FormState> formkey4 = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('UserData');

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 30, bottom: 10, top: 10),
                          child: Row(children: [
                            Text(
                              "Sign Up",
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
                              "Create an Account with your LUMS email",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.50),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          makeInput(
                              label: "Email",
                              icons: Icon(Icons.email, color: Colors.black),
                              controllerObj: emailController,
                              fk: formkey1),
                          makeInput(
                              label: "Name",
                              icons: Icon(Icons.person, color: Colors.black),
                              controllerObj: nameController,
                              fk: formkey2),
                          makeInput(
                              label: "Password",
                              icons: Icon(Icons.lock, color: Colors.black),
                              obsureText: true,
                              controllerObj: password1Controller,
                              fk: formkey3),
                          Padding(
                              padding: const EdgeInsets.only(
                                bottom: 40,
                              ),
                              child: makeInput(
                                  label: "Confirm Password",
                                  icons: Icon(Icons.lock, color: Colors.black),
                                  obsureText: true,
                                  controllerObj: password2Controller,
                                  fk: formkey4,
                                  p1controller: password1Controller)),
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
                            print("hello world");
                            // String val = "";
                            if (formkey1.currentState!.validate() &&
                                formkey2.currentState!.validate() &&
                                formkey3.currentState!.validate() &&
                                formkey4.currentState!.validate()) {
                                  showLoaderDialog(context);
                              // Future<dynamic>
                              // String val =
                              signUp(
                                  emailController.text,
                                  password1Controller.text,
                                  nameController.text,
                                  context);
                            }
                          },
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: const Text(
                            "SIGN  UP",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 35),
                          child: const Text("Already have an account?"),
                        ),
                        TextButton(
                          // style: TextButton.styleFrom(
                          //   textStyle: const TextStyle(
                          //       // fontSize: 16,
                          //       // fontWeight: FontWeight.w600,
                          //       //decoration: TextDecoration.underline
                          //       ),
                          //   primary: Colors.black,
                          // ),
                          onPressed: () {
                            // print("Container clicked");
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => Login()));
                          },
                          child: const Text('Log in',
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

  // Future<void>
  addUser(emailID, password1, name, context) async {
    users.add({
      "email": emailID,
      "imageURL":
          "https://firebasestorage.googleapis.com/v0/b/backspace-current.appspot.com/o/UserImages%2Fdefault.png?alt=media&token=dc5d36d7-0cb9-4b94-a36d-2f58bf776be5",
      // "password": password1,
      "username": name,
      "roles": "user",
      "about": "",
      "blocked": false,
    }).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => BottomNavigation()));
    }).catchError((error) => print("Failed to add user: $error"));
    return;
  }

  signUp(emailAddress, password, name, context) async {
    // CollectionReference users = FirebaseFirestore.instance.collection('UserData');
    print(emailAddress);
    print(password);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      addUser(emailAddress, password, name, context);
    } on FirebaseAuthException catch (e) {
      // print(Errors.show(e.code));
      // print(e.message);
      String? x = e.message;
      Fluttertoast.showToast(msg: x!, gravity: ToastGravity.TOP);
    } catch (e) {
      print(e);
    }
  }
}

Widget makeInput(
    {label,
    icons,
    obsureText = false,
    controllerObj,
    fk,
    p1controller = null}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      Form(
        key: fk,
        child: TextFormField(
          obscureText: obsureText,
          decoration: InputDecoration(
            prefixIcon: Align(
              widthFactor: 2,
              heightFactor: 1.0,
              child: icons,
            ),
            fillColor: Color(0xfff9f9fa),
            filled: true,
            //icon: Icon(Icons.favorite),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff000000)),
            ),
          ),
          controller: controllerObj,
          validator: (value) {
            // final FirebaseAuth auth = FirebaseAuth.instance;
            // final user = auth.currentUser;
            // final emailid = user!.email;
            // String emailID = user.email;
            // print(emailid);

            // final User user = await FirebaseAuth.instance.currentUser;
            if (label == "Confirm Password") {
              if (value == null || value.isEmpty) {
                return 'Please enter the password again';
              } else if (p1controller.text != value) {
                return "Password is not same";
              } else {
                return null;
              }
            } else if (label == "Password") {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              } else {
                return null;
              }
            } else if (label == "Email") {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (value.length < 20) {
                return "Enter a valid LUMS email";
              } else if (value.substring(value.length - 12) != "@lums.edu.pk") {
                return "Enter a valid LUMS email";
              } else {
                return null;
              }
            } else if (label == "Name") {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else {
                return null;
              }
            }
            // return null;
          },
          // onSaved: (value) {
          //   controllerObj.text = value!;
          // },
          //  onSaved: (val)=>_password=val,
        ),
      ),
      SizedBox(
        height: 30,
      ),
    ],
  );
}
