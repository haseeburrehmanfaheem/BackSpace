// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:convert';

import 'package:backspace/pages/Messages.dart';
import 'package:backspace/pages/Notification.dart';
import 'package:backspace/pages/add-post.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:backspace/helper/demo_values.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:sticky_float_button/sticky_float_button.dart';

import '../components/newsFeed/post-body/posts-text.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';

class CommentsDisplay extends StatelessWidget {
  final String userImg;
  final String Time;
  final String name;
  final String posttext;
  // ignore: use_key_in_widget_constructors
  const CommentsDisplay(
      {required this.userImg,
      required this.name,
      required this.Time,
      required this.posttext});
  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //clipBehavior: Clip.antiAlias,
        // child:
        Column(children: [
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 15)),
                  CircleAvatar(
                    backgroundImage: NetworkImage(userImg),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: MediaQuery.of(context).size.width / 10,
                      ),
                      // EdgeInsets.only(left: 10, top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(posttext,
                                // maxLines: 4,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14)),
                          ),
                        ],
                      )),
                ],
              ),
              
            ],
          ),
        ),
      ),
      Divider(height: 1),
    ]
            // )
            );
    // elevation: 5,
    //)
  }
}
