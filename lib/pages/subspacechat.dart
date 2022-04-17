import 'package:backspace/pages/Notification.dart';
import 'package:flutter/material.dart';
import 'package:backspace/pages/newsfeed.dart';

import 'package:backspace/pages/Instructor.dart';

import 'NFeed.dart';

class SubSpaceChat extends StatelessWidget {
  final String name;
  final String image;
  final String about;

  const SubSpaceChat({
    required this.name,
    required this.image,
    required this.about,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text(name, style: TextStyle(fontFamily: "Poppins")),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Simple(
          title: about,
          imagePath: image,
          about: about,
        ),
        // ),
      ),
    );
  }
}

var addsubspacecontroller = TextEditingController();

class Simple extends StatefulWidget {
  final String title;
  final String imagePath;
  final String about;
  // var selected;

  Simple({
    required this.title,
    required this.imagePath,
    required this.about,
    // this.selected
  });

  @override
  State<Simple> createState() => _SimpleState();
}

class _SimpleState extends State<Simple> {
  // var _selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(5),
      child: Stack(
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 20)),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.imagePath),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Text(widget.about,
                          style: TextStyle(fontSize: 18, letterSpacing: 0.2)),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AddSubspaceForm(
                postcontentController: addsubspacecontroller,
                hintText: "Send Message",
                subspaceName: widget.title,
              ),
            ),
          ]),
    );
  }
}

class AddSubspaceForm extends StatefulWidget {
  final TextEditingController postcontentController;
  final String hintText;
  final String subspaceName;

  const AddSubspaceForm(
      {Key? key,
      required this.hintText,
      required this.postcontentController,
      required this.subspaceName})
      : super(key: key);

  @override
  AddPostFormState createState() => AddPostFormState();
}

class AddPostFormState extends State<AddSubspaceForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: Row(children: <Widget>[
          Expanded(
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: widget.postcontentController,
                // onTap: () {

                // },
                // onPre

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  fillColor: const Color(0xfff9f9fa),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              // ),
              // ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_outlined),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print(widget.postcontentController.text);
                print("asd");
              }
            },
          ),
        ]),
      ),
    );
  }
}
