import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static Future<String?> uploadFile(String dest, File file) async {
    try {
      UploadTask uploadFile = FirebaseStorage.instance.ref(dest).putFile(file);
      TaskSnapshot snapshot = await uploadFile;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> searchCollection(
    String collection,
    String fieldName,
    String searchString, [
    String? field,
    fieldCategory,
  ]) async {
    /* Remember to check for exceptions In case any error with getting snapshot */
    try {
      QuerySnapshot allItems;
      if (field != null) {
        allItems = await FirebaseFirestore.instance
            .collection(collection)
            .where(field, isEqualTo: fieldCategory)
            .get();
      } else {
        allItems =
            await FirebaseFirestore.instance.collection(collection).get();
      }

      print(allItems.docs);
      /* Map List of DocumentSnapshot Objects to a List of key value pairs*/
      final allItemsMap = allItems.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        data["ItemID"] = doc.id;
        return data;
      }).toList();

      /* Filter out matching users */

      return allItemsMap
          .where((item) => item[fieldName]
              .toLowerCase()
              .contains(searchString.toLowerCase()))
          .toList();
    } on FirebaseException catch (e) {
      print("Inside Firebase Api class");
      print(e.message);
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> returnAllUsers() async {
    final QuerySnapshot allUsers =
        await FirebaseFirestore.instance.collection("UserData").get();

    /* Map List of DocumentSnapshot Objects to a List of key value pairs*/
    return allUsers.docs.map((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return data;
    }).toList();
  }

  static Future<String?> getChatID(emailUser1, emailUser2) async {
    /* Getting chat ID for messages */
    try {
      String chatID = "${emailUser1}_$emailUser2";
      var chat =
          await FirebaseFirestore.instance.collection("chat").doc(chatID).get();
      if (!chat.exists) {
        chatID = "${emailUser2}_$emailUser1";
        chat = await FirebaseFirestore.instance
            .collection("chat")
            .doc(chatID)
            .get();
      }
      return chatID;
    } on Exception catch (e) {
      print("Error occured while getting chatID");
      print(e);
      return null;
    }
  }
}
