// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:backspace/pages/newsfeed.dart';
import 'package:backspace/pages/signup.dart';
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
  // final String email;
  // final String password;
  // _LoginState(this.email, this.password);
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
                          height: 50,
                          onPressed: () {
                            // print("hello world");
                            // if()
                            // print(nameController.text);
                            // print(emailController.text);
                            // print(formkey1.currentState!.validate());
                            if (formkey1.currentState!.validate() &&
                                formkey2.currentState!.validate()) {
                              login(emailController.text,
                                  passwordController.text, context);
                              //  Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (_) => BottomNavigation()));
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //     backgroundColor: Colors.white,
                              //     content: Text(
                              //       'Validation Successful',
                              //       style: TextStyle(
                              //         color: Colors.black,
                              //       ),
                              //     ),
                              //   ),
                              // );
                            }
                            // Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (_) => BottomNavigation()));
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
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => BottomNavigation()));
    print('The user has been logged in');
  } on FirebaseAuthException catch (e) {
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
