import 'package:backspace/Services/AuthenticationServices.dart';
import 'package:backspace/model/errors.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Create an Account with your LUMS email",
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
                              label: "Name",
                              controllerObj: nameController,
                              fk: formkey2),
                          makeInput(
                              label: "Password",
                              obsureText: true,
                              controllerObj: password1Controller,
                              fk: formkey3),
                          makeInput(
                              label: "Confirm Password",
                              obsureText: true,
                              controllerObj: password2Controller,
                              fk: formkey4,
                              p1controller: password1Controller)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: const EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: const Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black))),
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
                              // Future<dynamic> 
                              // String val = 
                              signUp(emailController.text,
                                  password1Controller.text);
                                  // print(val);
                                  // if(val == ""){
                                  //   print("val ");
                                  //   print(val);
                                  // } 
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
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) => BottomNavigation()));
                            }
                          },
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
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
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => Login()));
                          },
                          child: const Text('Log in'),
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

  signUp(emailAddress, password) async {
    print(emailAddress);
    print(password);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      
    } on FirebaseAuthException catch (e) {
      // print(Errors.show(e.code));
      // print(e.message);
      String? x  = e.message;
      Fluttertoast.showToast(msg: x!, gravity: ToastGravity.TOP);
      // return Errors.show(e.code);
      // if (e.code == 'weak-password') {
      //   // print(Errors.show())
      //   print('The password provided is too weak.');
      //   // errValue = "The password provided is too weak.";
      // } else if (e.code == 'email-already-in-use') {
      //   print('The account already exists for that email.');
      //   // this.error =
      //   //  = "The account already exists for that email." setState((){})
      //   // return "The account already exists for that email.";
      //   // errValue = "The account already exists for that email.";
      // }
    } 
    // catch (e) {
    //   print(e);
    // }
  }
}

Widget makeInput(
    {label, obsureText = false, controllerObj, fk, p1controller = null}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      Form(
        key: fk,
        child: TextFormField(
          obscureText: obsureText,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
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
