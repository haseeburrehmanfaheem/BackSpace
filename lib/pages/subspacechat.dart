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
        body: SingleChildScrollView(
          child: Simple(
            userName: about,
            imagePath: image,
            about: about,
          ),
        ),
      ),
    );
  }
}

var addsubspacecontroller = TextEditingController();

class Simple extends StatefulWidget {
  final String userName;
  final String imagePath;
  final String about;
  // var selected;

  Simple({
    required this.userName,
    required this.imagePath,
    required this.about,
    // this.selected
  });

  @override
  State<Simple> createState() => _SimpleState();
}

class _SimpleState extends State<Simple> {
  var _selected;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
      Divider(color: Colors.grey),

      Align(
        alignment: Alignment.bottomCenter,
        child: AddPostForm(
          showImagesIcons: true,
          postcontentController: addsubspacecontroller,
          sendButton: IconButton(
              /* Send Message here */
              onPressed: () async {
                // await sendMessage(
                //   _messageContentController.text,
                //   img,
                //   currentUser,
                //   widget.receiver,
                // );
                // _messageContentController.text = '';
                // img = null;
              },
              icon: const Icon(Icons.send)),
          hintText: "Send Message",
          // changeState: changeState,
          openPopup: () {
            _openDialog(context);
          },
        ),
      ),
      // Container(
      //           alignment: Alignment.bottomCenter,
      //           width: MediaQuery.of(context).size.width,
      //           child: Container(
      //             padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      //             color: Colors.grey[100],
      //             child: Row(
      //               children: <Widget>[
      //                 Expanded(
      //                   child: TextField(
      //                     // controller: messageEditingController,
      //                     style: TextStyle(
      //                       color: Colors.black
      //                     ),
      //                     decoration: InputDecoration(
      //                       hintText: "Send a message ...",
      //                       hintStyle: TextStyle(
      //                         color: Colors.black,
      //                         fontSize: 16,
      //                       ),
      //                       border: InputBorder.none
      //                     ),
      //                   ),
      //                 ),

      //               ],
      //             ),
      //           ),

      // ),
    ]);
  }

  void _openDialog(BuildContext context) async {
    _selected = await Navigator.of(context).push(MaterialPageRoute<String>(
        builder: (BuildContext context) {
          return Scaffold(
            // extendBodyBehindAppBar: true,
            appBar: AppBar(
              // backgroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Colors.black,
              title: const Text('Send'),
              actions: [],
            ),
            body:
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height,
                //   padding: EdgeInsets.all(5),
                //   color: Colors.white,
                // child:

                Stack(children: [
              Container(
                child: Text("wtf"),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: AddPostForm(
                    showImagesIcons: false,
                    postcontentController: addsubspacecontroller,
                    // changeState: changeState,
                    hintText: "Send Message",
                    sendButton: IconButton(
                        /* Send Message here */
                        onPressed: () async {
                          // await sendMessage(
                          //   _messageContentController.text,
                          //   img,
                          //   currentUser,
                          //   widget.receiver,
                          // );
                          // Navigator.of(context).pop();
                          // _messageContentController.text = '';
                          // setState(() => {img = null});
                        },
                        icon: const Icon(Icons.send)),
                  )),
            ]),
            // ),
          );
        },
        fullscreenDialog: true));
    if (_selected != null) {
      setState(() {
        _selected = _selected;
      });
    }
  }
}
