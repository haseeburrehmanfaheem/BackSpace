import 'package:backspace/pages/newsfeed.dart';
import 'package:backspace/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome back, Login to continue",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          makeInput(
                              label: "Email",
                              controllerObj: emailController,
                              fk: formkey1),
                          makeInput(
                              label: "Password",
                              obsureText: true,
                              controllerObj: passwordController,
                              fk: formkey2),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: const EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                          
                          // prefixIcon: prefixIcon??Icon(Icons.done),
                            borderRadius: BorderRadius.circular(40),
                            border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black))),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            // print("hello world");
                            // if()
                            // print(nameController.text);
                            // print(emailController.text);
                            // print(formkey1.currentState!.validate());
                            if (formkey1.currentState!.validate() &&
                                formkey2.currentState!.validate()) {
                                 login(emailController.text, passwordController.text, context);
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
                                fontWeight: FontWeight.w600,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            primary: Colors.black,
                          ),
                          onPressed: () {
                            // print("Container clicked");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignupPage()));
                          },
                          child: const Text('Sign up'),
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
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password
    );
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (_) => BottomNavigation()));
    print('The user has been logged in');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Fluttertoast.showToast(msg: "These credentials do not match our records", gravity: ToastGravity.TOP);
    } else if (e.code == 'wrong-password') {
      Fluttertoast.showToast(msg: "These credentials do not match our records.", gravity: ToastGravity.TOP);
    }
  }
}