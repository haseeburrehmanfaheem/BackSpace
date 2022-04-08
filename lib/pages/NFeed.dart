import 'package:backspace/pages/Notification.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:flutter/material.dart';
import 'package:backspace/helper/demo_values.dart';

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: Scaffold(
        backgroundColor: Colors.white,
        drawer: MyDrawer(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title:
              const Text('News Feed', style: TextStyle(fontFamily: "Poppins")),
          actions: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Icon(Icons.search, color: Colors.black)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  icon: Icon(Icons.notifications_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Noti()),
                    );
                  },
                ))
          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: ListView(
        children: <Widget> [ Post()
            // Card(
            //   clipBehavior: Clip.antiAlias,
            //   child: Column(
            //     children: [
            //       ListTile(
            //         leading: _UserImage(),
            //         // leading: CircleAvatar(
            //         //  backgroundImage: AssetImage(DemoValues.userImage)),
            //         title: const Text('Zeerak Babar'),
            //         trailing: const Text(DemoValues.postTime),
            //         // subtitle: Text(
            //         //   'Secondary Text',
            //         //   style: TextStyle(color: Colors.black.withOpacity(0.6)),
            //         // ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(16.0),
            //         // padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
            //         child: Text(
            //           'Lost keys found.. Submitted to security office  has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap int',
            //           style: TextStyle(fontFamily: "Poppins"),
            //         ),
            //       ),
            //       Image.asset('assets/images/keys.jpg'),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  } 
}

class Post extends StatelessWidget {
  const Post({Key? key,

  }) : super(key: key);
  static const String _username = 'Sana Arshad';

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    // leading: _UserImage(),
                    leading: CircleAvatar(
                     backgroundImage: AssetImage(DemoValues.userImage)),
                    title: const Text(_username),
                    trailing: const Text(DemoValues.postTime),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    // padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
                    child: Text(
                      DemoValues.postSummary,
                      style: TextStyle(fontFamily: "Poppins"),
                    ),
                  ),
                  
                  Image.asset('assets/images/keys.jpg'),


                  ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    Text('hello');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Noti()),
                    // );
                  },
                
                    ),
                    const Text('Like', style: TextStyle(fontFamily: "Poppins") ),
                    Padding(padding : EdgeInsets.only(right: 250.0) ),


                     IconButton(
                  icon: Icon(Icons.add_comment),
                  onPressed: () {
                    Text('hello');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Noti()),
                    // );
                  },
                    ),
                    const Text('Comment', style: TextStyle(fontFamily: "Poppins") ),
                  
                  ],

                ),


                ],
              ),
    );

  }
}