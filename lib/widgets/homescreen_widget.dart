import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../firebase/authentication.dart';
import '../pages/ApprovedPosts.dart';
import '../pages/homepage.dart';
import '../pages/newsfeed.dart';
import '../pages/splash_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Should be some splash screen here
        }
        // If the user exists and is signed in with his auth token find user type
        if (userSnapshot.hasData) {
          return FutureBuilder(
              future: AuthServices.checkUserType(
                  FirebaseAuth.instance.currentUser!.email),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          SplashScreen()); //Should be some splash screen here
                }
                //If is just regular user
                if (snapshot.data == AuthState.user) {
                  return const BottomNavigation();
                }
                //If is an admin and userType = AuthState.admin
                return const Proved();
              });
        }
        //Else user type is AuthState.guest
        return Home();
      },
    );
  }
}
