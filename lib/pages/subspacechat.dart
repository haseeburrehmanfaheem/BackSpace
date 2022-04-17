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
        body: 
        // SingleChildScrollView(
          // child: 
          Simple(
            userName: about,
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
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height ,
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
        // Divider(color: Colors.grey),


        Align(
          alignment: Alignment.bottomCenter,
          child: AddSubspaceForm(
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
            // openPopup: () {
            //   _openDialog(context);
            // },
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
      ]),
    );
  }

}


class AddSubspaceForm extends StatefulWidget {
  final TextEditingController postcontentController;
  // final Function? openPopup;
  // final Function(File)? changeState;
  final Widget? sendButton;
  final String hintText;
  final bool showImagesIcons;

  const AddSubspaceForm({
    Key? key,
    required this.showImagesIcons,
    required this.hintText,
    // this.openPopup,
    // this.changeState,
    this.sendButton,
    required this.postcontentController,
  }) : super(key: key);

  @override
  AddPostFormState createState() => AddPostFormState();
}

class AddPostFormState extends State<AddSubspaceForm> {
  final _formKey = GlobalKey<FormState>();
  // File? image;

  // Future handleChoosefromgallery() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);

  //     if (image == null) return;

  //     final imageTemp = File(image.path);

  //     setState(() => this.image = imageTemp);
  //     widget.changeState!(imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // Future handleTakephoto() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);

  //     if (image == null) return;

  //     final imageTemp = File(image.path);

  //     setState(() => this.image = imageTemp);
  //     widget.changeState!(imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return
        //
        Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
            // mainAxisSize: MainAxisSize.min, // added line
            children: <Widget>[
              Expanded(
                // child: Container(
                  // color: Colors.white,
                  child: Form(
                    key: _formKey,
                    // child: Container(
                      //  margin: EdgeInsets.all(15),
                      child: TextFormField(
                        controller: widget.postcontentController,
                        onTap: () {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          // enabledBorder: OutlineInputBorder(
                          // borderSide: BorderSide(
                          //     color: Colors.white,
                          //     ),
                          // borderRadius: BorderRadius.circular(50.0),
                          // ),
                          hintText: widget.hintText,
                          fillColor: const Color(0xfff9f9fa),
                          filled: true,
                          // isDense: true,
                          // contentPadding: EdgeInsets.fromLTRB(30, 30, 0, 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    // ),
                  // ),
                ),
              ),
              // if (widget.showImagesIcons)
              //   IconButton(
              //       onPressed: () async {
              //         await handleTakephoto();
              //         if (widget.openPopup != null) {
              //           widget.openPopup!();
              //         }
              //       }, //Open Camera here
              //       icon: const Icon(Icons.camera_alt_outlined)),
              // if (widget.showImagesIcons)
              //   IconButton(
              //       onPressed: () async {
              //         await handleChoosefromgallery();
              //         if (widget.openPopup != null) {
              //           // print('OpenPopup');
              //           widget.openPopup!();
              //         }
              //       }, //Open Gallery here
              //       icon: const Icon(Icons.photo)),
              if (widget.sendButton != null) widget.sendButton!,
            ]),
      ),
    );
  }
}
