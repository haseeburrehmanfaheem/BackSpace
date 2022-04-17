import 'package:backspace/helper/demo_values.dart';
import 'package:backspace/pages/AddEvent.dart';
import 'package:backspace/pages/ApprovedPosts.dart';
import 'package:backspace/pages/Chat.dart';
import 'package:backspace/pages/EditProfile.dart';
import 'package:backspace/pages/Messages.dart';
import 'package:backspace/pages/ViewProfile.dart';
import 'package:backspace/pages/homepage.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:backspace/pages/Subspace.dart';

import 'package:backspace/pages/subspacechat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lit_relative_date_time/lit_relative_date_time.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // new

import 'firebase_options.dart'; // new
import 'src/authentication.dart'; // new


Future<void> backroundHandler(RemoteMessage message) async {
  print(" This is message from background");
  print(message.notification!.title);
  print(message.notification!.body);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const Myapp({Key? key,this.signed_in}) : super(key: key);
  bool signed_in = false;
  bool is_admin = false;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.userChanges().listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        signed_in = true;
        final email = FirebaseAuth.instance.currentUser!.email;
        final temp = await getUserData(email);
        is_admin = (temp.docs[0]["roles"] == "admin");
        if (is_admin) {
          print("Is admin");
        } else {
          print("Is not admin");
        }
        // signout ki line
        // FirebaseAuth.instance.signOut();
      }
    });
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Set the supported locales according to the localizations you have
      // implmented on your application.
      supportedLocales: const [
        Locale('en'), // English, no country code
        Locale('de'), // German, no country code
        Locale('ru'), // Russian, no country code
      ],
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context)
              .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
      ),
      title: 'Backspace',
      debugShowCheckedModeBanner: false,
      home: signed_in ? (is_admin ? Proved() : BottomNavigation()) : Home(),

    );
  }
}

getUserData(email) async {
  return await FirebaseFirestore.instance
      .collection("UserData")
      .where("email", isEqualTo: email)
      .get();
}


class loading extends StatelessWidget {
  const loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Hello world"),
    );
  }
}
