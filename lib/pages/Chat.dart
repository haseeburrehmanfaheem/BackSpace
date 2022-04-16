// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';
import 'package:path/path.dart';

import 'package:backspace/pages/NFeed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import '../api/firebase-api.dart';
import 'Notification.dart';

class Chat extends StatefulWidget {
  final receiver;
  final chatID;
  Chat({Key? key, required this.receiver, required this.chatID})
      : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var _selected;
  File? img = null;

  final currentUser = FirebaseAuth.instance.currentUser;

  CollectionReference chat = FirebaseFirestore.instance.collection('chat');

  final _messageContentController = TextEditingController();

  changeState(imgSrc) {
    setState(() => img = imgSrc);
  }

  Widget senderOrReceiver(message) {
    return message["sent_by"] == currentUser?.email
        ? Reciever(postText: message["message_content"])
        : Sender(postText: message["message_content"]);
  }

  sendMessage(message, imageURL, currentUser, receiver) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    var chatID = await FirebaseApi.getChatID(
        currentUser?.email, widget.receiver["email"]);
    //Get user email and use it as id of document for chat
    CollectionReference chat = FirebaseFirestore.instance.collection('chat');
    CollectionReference messages =
        FirebaseFirestore.instance.collection('messages');

    chat.doc(chatID).set({
      'user1': currentUser?.email,
      'user2': receiver["email"],
      'last_messsage': '',
      'last_message_time': null,
    });

    String? downloadURL = "";
    if (imageURL != null) {
      String fileName = basename(imageURL!.path);
      final timeNow = DateTime.now();
      String storagePath =
          "UserImages/chat/${currentUser?.email}_${receiver['email']}_${timeNow}_$fileName";
      downloadURL = await FirebaseApi.uploadFile(storagePath, imageURL);
      if (downloadURL == null) {
        print("Something Went wrong in uploading the image");
        return;
      }
    }
    final messageTime = DateTime.now();

    try {
      await messages.add({
        'chat_id': chatID,
        'message_content': message,
        'message_image': downloadURL,
        'sent_by': currentUser?.email,
        'sent_at': messageTime,
      });

      await chat.doc(chatID).update({
        'last_message_time': messageTime,
        'last_messsage': message,
      });
    } on Exception catch (e) {
      print("Something went wrong while sending message");
      print(e);
    }

    //set all fields and then add Last message sent in case message sent
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
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Stack(children: [
                img != null
                    ? Image.file(
                        img!,
                        fit: BoxFit.cover,
                      )
                    : Container(),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: AddPostForm(
                      showImagesIcons: false,
                      postcontentController: _messageContentController,
                      changeState: changeState,
                      hintText: "Send Message",
                      sendButton: IconButton(
                          /* Send Message here */
                          onPressed: () async {
                            await sendMessage(
                              _messageContentController.text,
                              img,
                              currentUser,
                              widget.receiver,
                            );
                            Navigator.of(context).pop();
                            _messageContentController.text = '';
                            setState(() => {img = null});
                          },
                          icon: const Icon(Icons.send)),
                    )),
              ]),
            ),
          );
        },
        fullscreenDialog: true));
    if (_selected != null) {
      setState(() {
        _selected = _selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseApi.getAllMessages(currentUser?.email, widget.receiver["email"]);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text(widget.receiver["username"], style: TextStyle()),
          actions: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.search, color: Colors.black)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  icon: Icon(Icons.notifications_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Noti()),
                    );
                  },
                ))
          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: 
        Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.80,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("messages")
                  .where('chat_id', isEqualTo: widget.chatID)
                  .orderBy('sent_at')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(widget.chatID);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                return ListView(
                  children:
                      snapshot.data.docs.map<Widget>((DocumentSnapshot document) {
                    Map<String, dynamic> message =
                        document.data()! as Map<String, dynamic>;
                    return senderOrReceiver(message);
                  }).toList(),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AddPostForm(
              showImagesIcons: true,
              postcontentController: _messageContentController,
              sendButton: IconButton(
                  /* Send Message here */
                  onPressed: () async {
                    await sendMessage(
                      _messageContentController.text,
                      img,
                      currentUser,
                      widget.receiver,
                    );
                    _messageContentController.text = '';
                    img = null;
                  },
                  icon: const Icon(Icons.send)),
              hintText: "Send Message",
              changeState: changeState,
              openPopup: () {
                _openDialog(context);
              },
            ),
          ),
        ]));
  }
}

class Sender extends StatelessWidget {
  final String? userImage;
  final String postText;
  // ignore: use_key_in_widget_constructors
  const Sender({this.userImage, required this.postText});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5, left: 5),
        child: Row(
          children: [
            // CircleAvatar(
            //   backgroundImage: NetworkImage(userImage!),
            // ),
            BubbleSpecialThree(
              text: postText,
              color: Color(0xFFE8E8EE),
              tail: false,
              isSender: false,
            ),
          ],
        ));
  }
}

class Reciever extends StatelessWidget {
  final String postText;
  // ignore: use_key_in_widget_constructors
  const Reciever({required this.postText});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5),
        child: BubbleSpecialThree(
          text: postText,
          color: Color(0xFF323232),
          tail: false,
          textStyle: TextStyle(color: Colors.white, fontSize: 16),
        ));
  }
}
