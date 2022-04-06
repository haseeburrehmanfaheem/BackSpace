import 'package:flutter/material.dart';

class SubSpace extends StatelessWidget {
  const SubSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const Icon(Icons.menu, color: Colors.black),
          title:
              const Text('Sub Space', style: TextStyle(fontFamily: "Poppins")),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Icon(Icons.search, color: Colors.black),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.notifications_outlined, color: Colors.black)),
          ],
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
