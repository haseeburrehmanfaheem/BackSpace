// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Noti extends StatefulWidget {
  // String notificationMsg = "Waiting for notifications";
  const Noti({Key? key}) : super(key: key);
  

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  String notificationMsg = "Waiting for notifications";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // LocalNotificationService.initilize();

    // Terminated State
    // FirebaseMessaging.instance.getInitialMessage().then((event) {
    //   if (event != null) {
    //     setState(() {
    //       notificationMsg =
    //           "${event.notification!.title} ${event.notification!.body} I am coming from terminated state";
    //     });
    //   }
    // });

    // // Foregrand State
    // FirebaseMessaging.onMessage.listen((event) {
    //   // LocalNotificationService.showNotificationOnForeground(event);
    //   setState(() {
    //     notificationMsg =
    //         "${event.notification!.title} ${event.notification!.body} I am coming from foreground";
    //   });
    // });

    // // background State
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   setState(() {
    //     notificationMsg =
    //         "${event.notification!.title} ${event.notification!.body} I am coming from background";
    //   });
    // });
  }

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
          title: const Text('Notifications',
              style: TextStyle(fontFamily: "Poppins")),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
