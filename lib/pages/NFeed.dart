import 'dart:io';

import 'package:backspace/pages/Notification.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:backspace/helper/demo_values.dart';
import 'package:image_picker/image_picker.dart';

import '../components/newsFeed/post-body/posts-text.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';
final usersRef = FirebaseFirestore.instance.collection('UserData'); //database reference object
class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('News Feed'),
        actions: [
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Icon(Icons.search, color: Colors.black)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Noti()),
                  );
                },
              ))
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: const <Widget>[
          Expanded(
            child: Post(),
          ),
          // AddPost(),
        ],
      ),
    );
  }
}

class timeline extends StatefulWidget{

  @override 
  _timeline createState() => _timeline();
}

class _timeline extends State<timeline> {
  @override 
  void initState(){
    getUsers();
    super.initState();
  }
  Future<void> getUsers() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await usersRef.get();

    // Get data from docs and convert map to List
    querySnapshot.docs.forEach((doc) {print(doc.id ); });
    //  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    // print(allData);
}


  @override
   Widget build(BuildContext context){
     return Scaffold(
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('News Feed', style: TextStyle(fontFamily: "Poppins")),
        actions: [
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Icon(Icons.search, color: Colors.black)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Noti()),
                  );
                },
              ))
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: const <Widget>[
          Expanded(
            child: Post(),
          ),
          // AddPost(),
        ],
      ),
    );
   }
}




// final databaseRef = FirebaseFirestore.instance.collection('UserData'); //database reference object
// Future<void> getData() async {
//     // Get docs from collection reference
//     QuerySnapshot querySnapshot = await databaseRef.get();

//     // Get data from docs and convert map to List
//     final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

//     print(allData);
// }




class Post extends StatelessWidget {
  const Post({
    Key? key,
  }) : super(key: key);
  static const String _username = 'Sana Arshad';

  @override
  Widget build(BuildContext context) {
    return 
      Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const UserIconName(
            userImage: DemoValues.userImage,
            username: _username,
            postTime: DemoValues.postTime,
          ),
          const PostBody(postSummary: DemoValues.postSummary),
          Image.asset('assets/images/keys.jpg'),
          const PostFooter(),
          const AddPostForm(),
          
        ],
      ),
    );
    
    
    
  }
}

// Display Like and Comment Post Footer Bar
class PostFooter extends StatefulWidget {
  const PostFooter({Key? key}) : super(key: key);

  @override
  _PostFooter createState() => _PostFooter();
}

class _PostFooter extends State<PostFooter> {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.only(left: 20.0)),
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {
            // Set State for Likes and update db.
          },
        ),
        const Text('Like', style: TextStyle(fontFamily: "Poppins")),
        const Padding(padding: EdgeInsets.only(left: 70.0)),
        IconButton(
          icon: const Icon(Icons.add_comment),
          onPressed: () {
            // pass
          },
        ),
        const Text('Comment', style: TextStyle(fontFamily: "Poppins")),
      ],
    );
  }
}


class AddPostForm extends StatefulWidget {
  const AddPostForm({Key? key}) : super(key: key);

  @override
  AddPostFormState createState() => AddPostFormState();
}

class AddPostFormState extends State<AddPostForm> {
  final _formKey = GlobalKey<FormState>();

  // Future pickImage() async {
  //   ImagePicker.pickImage(source: ImageSource.camera);
  // }
  File? file;
  handleTakephoto() async {
    Navigator.pop(context);
    var file = await ImagePicker().pickImage(source: ImageSource.camera, 
    maxHeight: 675, maxWidth: 960,);
    setState((){
      this.file = File(file!.path);
    });

  }
  handleChoosefromgallery() async {
    Navigator.pop(context);
    var file = await ImagePicker().pickImage(source: ImageSource.gallery, 
    maxHeight: 675, maxWidth: 960,);
    setState((){
      this.file = File(file!.path);
    });
  }


  @override
  Widget build(BuildContext context) {
    return (Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Text';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Add Post",
                fillColor: const Color(0xfff9f9fa),
                filled: true,
                suffixIcon: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // added line
                  mainAxisSize: MainAxisSize.min, // added line
                  children: <Widget>[
                    IconButton(
                        onPressed: handleTakephoto, //Open Camera here
                        icon: const Icon(Icons.camera_alt_outlined)),
                    IconButton(
                        onPressed: handleChoosefromgallery, //Open Gallery here
                        icon: const Icon(Icons.photo)),
                    IconButton(
                        onPressed: () {}, //post the post
                        icon: const Icon(Icons.arrow_forward)),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ))));
  }
}









// class AddPost extends StatefulWidget{

//   // final User currentUser;

//   // AddPost({this.currentUser });

//   @override 
//   _UploadState createState() => _UploadState();
// }
// class _UploadState extends State<AddPost> {

//   File? file;


//   handleTakephoto() async {
//     Navigator.pop(context);
//     var file = await ImagePicker().pickImage(source: ImageSource.camera, 
//     maxHeight: 675, maxWidth: 960,);
//     setState((){
//       this.file = File(file!.path);
//     });

//   }
//   handleChoosefromgallery() async {
//     Navigator.pop(context);
//     var file = await ImagePicker().pickImage(source: ImageSource.gallery, 
//     maxHeight: 675, maxWidth: 960,);
//     setState((){
//       this.file = File(file!.path);
//     });
//   }

//   selectImage(Parentcontext){
//     return showDialog(
//       context: Parentcontext,
//       builder: (context){
//         return SimpleDialog(
//           title: Text("Create Post"),
//           children: <Widget>[
//             SimpleDialogOption(
//               child: Text("Photo with Camera"),
//               onPressed: handleTakephoto,
//             ),
//             SimpleDialogOption(
//               child: Text("Image from gallery"),
//               onPressed: handleChoosefromgallery,
//             ),
//             SimpleDialogOption(
//               child: Text("Cancel"),
//               onPressed: () => Navigator.pop(context),
//             )
//           ],
//         );
//       }

//     );
//   }


//   Buildpostsplashscreen()
//   {
//     return Column
//     (
//       children: <Widget>[  
//                 Padding(  
//                   padding: EdgeInsets.all(15),  
//                   child: TextField(  
//                     decoration: InputDecoration(  
//                       border: OutlineInputBorder(),  
//                       hintText: 'Add post..',  
//                     ),  
//                   ),  
//                 ),  

//         IconButton(
//                 icon: const Icon(Icons.camera_alt_outlined),
//                 onPressed: () => selectImage(context)
//               ),

//       ],
//     );
  
//           //     TextField(
//           //   decoration : InputDecoration(
//           //     hintText: "Add new post..",
//           //     border: InputBorder.none,
//           //     prefixIcon: Icon(Icons.camera_alt_outlined),

//           //   ),
//           // ),
              
//   }
//   Container Builduploadform()
//   {
//     return Scaffold(
      
//     );
//     // return Container(
      
//     //   Text('title'),
//     //   // decoration: BoxDecoration(
//     //   //   image: DecorationImage(
//     //   //     fit: BoxFit.cover, image: FileImage(file!),
//     //   //   ),
//     //   // ),
//     // );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return file == null? Buildpostsplashscreen() : Builduploadform() ;
//     // return Buildpostsplashscreen();
//     // return Buildpostsplashscreen();
            

            
//   }
// }
