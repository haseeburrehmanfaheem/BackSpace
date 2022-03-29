// ignore_for_file: prefer_const_constructors

// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/loginpage.dart';
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
                // onTap: () {
                //   _navigateToNextScreen();
                // },
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
                  print("Container clicked");
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

final _formKeyemail = GlobalKey<FormState>();
final _formKey1password = GlobalKey<FormState>();
final _formKey2password = GlobalKey<FormState>();
final _formKeyname = GlobalKey<FormState>();

// Scaffold BuildUnauthScreen(BuildContext context) {
//   return Scaffold(
//     body: Container(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             // Text(
//             //   "BackSpace",
//             //   style: TextStyle(
//             //     fontSize: 60.0,
//             //     color: Colors.black,
//             //   ),
//             // )
//             Container(
//               height: 360.0,
//               width: 360.0,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/Logo.png'),
//                   fit: BoxFit.fill,
//                 ),
//                 shape: BoxShape.circle,
//               ),
//             ),
//             GestureDetector(
//               // onTap: () {
//               //   _navigateToNextScreen();
//               // },
//               child: Container(
//                 width: 380,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage('assets/widgets/loginbutton.png'),
//                       fit: BoxFit.fill),
//                 ),
//               ),
//             ),
//             SizedBox(height: 40),
//             GestureDetector(
//               // onTap: () => print("hello world"),
//               onTap: () {
//                 print("Container clicked");
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (_) => SignupPage()));
//               },
//               child: Container(
//                 width: 380,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage('assets/widgets/signupbutton.png'),
//                       fit: BoxFit.fill),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }

// void _navigateToNextScreen(BuildContext context) {
//   Navigator.of(context)
//       .push(MaterialPageRoute(builder: (context) => NewScreen()));
// }

// class NewScreen extends StatelessWidget {
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
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Screen')),
      body: Center(
        child: Text(
          'This is a new screen',
          style: TextStyle(fontSize: 24.0),
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
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
GlobalKey<FormState> formkey3 = GlobalKey<FormState>();
GlobalKey<FormState> formkey4 = GlobalKey<FormState>();

final TextEditingController emailController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController password1Controller = TextEditingController();
final TextEditingController password2Controller = TextEditingController();

class SignupPage extends StatelessWidget {
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
            icon: Icon(
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
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Create an Account with your LUMS email",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
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
                              fk: formkey4)
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
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
                                formkey2.currentState!.validate() &&
                                formkey3.currentState!.validate() &&
                                formkey4.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.white,
                                  content: Text(
                                    'Validation Successful',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
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
                        Text("Already have an account? "),
                        Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
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

// class name extends StatefulWidget {
//   name({Key? key}) : super(key: key);

//   @override
//   State<name> createState() => _nameState();
// }

// class _nameState extends State<name> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class makeInput extends StatefulWidget {
//   makeInput({Key? key}) : super(key: key);

//   @override
//   State<makeInput> createState() => _makeInputState();
// }

// class _makeInputState extends State<makeInput> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

Widget makeInput({label, obsureText = false, controllerObj, fk}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      Form(
        key: fk,
        child: TextFormField(
          obscureText: obsureText,
          decoration: InputDecoration(
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
            if (label == "Confirm Password") {
              if (value == null || value.isEmpty) {
                // print(password1Controller.text);
                // print(password2Controller.text);
                // print("CUnt");
                return 'Please enter some text';
              } else if (password1Controller.text != value) {
                return "zzeerak is cunt";
              }
            } else if (value == null || value.isEmpty) {
              // print(password1Controller.text);
              // print(password2Controller.text);
              // print("CUnt");
              return 'Please enter some text';
            }
            return null;
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
