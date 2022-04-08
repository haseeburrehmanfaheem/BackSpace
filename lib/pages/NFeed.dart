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
          children: <Widget>[
            Expanded(
              child: Post(),
            ),
            AddPost()
          ],
        ),
      ),
    );
  }
}

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
        // alignment: Alignment.bottomRight,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: TextField(
              //cursorColor: Theme.of(context).cursorColor,
              // maxLength: 20,

              decoration: InputDecoration(
                hintText: "Add Post",
                fillColor: Color(0xfff9f9fa),
                filled: true,
                suffixIcon: Icon(Icons.camera_alt_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            )));
  }
}

class Post extends StatelessWidget {
  const Post({
    Key? key,
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
            leading:
                CircleAvatar(backgroundImage: AssetImage(DemoValues.userImage)),
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
              const Text('Like', style: TextStyle(fontFamily: "Poppins")),
              const Padding(padding: EdgeInsets.only(right: 250.0)),
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
              const Text('Comment', style: TextStyle(fontFamily: "Poppins")),
            ],
          ),
        ],
      ),
    );
  }
}
