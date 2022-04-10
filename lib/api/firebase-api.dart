import 'dart:io';
import 'dart:typed_data';
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
}
