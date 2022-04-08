import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createNewUser(String email, String password) async {
    try {
      // FireBaseUser user =  await _auth.createUserWithEmailAndPassword(email: email, password: password)
    } catch (e) {
      print(e.toString());
    }
  }
}
