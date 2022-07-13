import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthState {
  user,
  admin,
  guest,
}

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createNewUser(String email, String password) async {
    try {
      // FireBaseUser user =  await _auth.createUserWithEmailAndPassword(email: email, password: password)
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<AuthState> checkUserType(String? email) async {
    if (email != null) {
      final emailResult = await AuthServices._getUserData(email);
      if (emailResult["roles"] == "admin") {
        return AuthState.admin;
      } else {
        return AuthState.user;
      }
    }
    return AuthState.guest;
  }

  static Future<QueryDocumentSnapshot<Map<String, dynamic>>> _getUserData(
      email) async {
    return (await FirebaseFirestore.instance
            .collection("UserData")
            .where("email", isEqualTo: email)
            .get())
        .docs[0];
  }
}
