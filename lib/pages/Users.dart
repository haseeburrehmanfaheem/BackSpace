// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'Admindrawer.dart';

class Block extends StatelessWidget {
  const Block({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AdminDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Block Users'),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: Icon(Icons.search), onPressed: () {},
                // onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => Noti()),
                //   );
                // },
              ))
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
