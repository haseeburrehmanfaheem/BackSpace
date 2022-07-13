import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:google_fonts/google_fonts.dart';

import './firebase_options.dart';
import './widgets/homescreen_widget.dart';

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        home: const HomeScreen()
        //  signed_in ? (is_admin ? Proved() : BottomNavigation()) : Home(),
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
