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
        children: [
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                     backgroundImage: AssetImage(DemoValues.userImage)),
                    title: const Text('Zeerak Babar'),
                    trailing: const Text(DemoValues.postTime),
                    // subtitle: Text(
                    //   'Secondary Text',
                    //   style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    // padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
                    child: Text(
                      'Lost keys found.. Submitted to security office',
                      style: TextStyle(fontFamily: "Poppins"),
                    ),
                  ),
                  // ButtonBar(
                  //   alignment: MainAxisAlignment.start,
                  //   children: [
                  //     FlatButton(
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 1'),
                  //     ),
                  //     FlatButton(
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 2'),
                  //     ),
                  //   ],
                  // ),
                  Image.asset('assets/images/keys.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } 
}
// Padding(
//           padding: const EdgeInsets.only(left: 8),
//           child: Column(
//             /// Add this
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 'Marry Jane',
//                 style: TextStyle(fontSize: 16),
//               ),
//               Text(
//                 'Make-up Artist',
//                 style: TextStyle(fontSize: 14, color: Color(0xff666666)),
//               ),
//               Text(
//                 '3.5',
//                 style: TextStyle(fontSize: 18, color: Color(0xff666666)),
//               ),
//             ],
//           ),
//         )
// class _MyHomePageState extends State<MyHomePage> {
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//             Card(
//               clipBehavior: Clip.antiAlias,
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: Icon(Icons.arrow_drop_down_circle),
//                     title: const Text('Card title 1'),
//                     subtitle: Text(
//                       'Secondary Text',
//                       style: TextStyle(color: Colors.black.withOpacity(0.6)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
//                       style: TextStyle(color: Colors.black.withOpacity(0.6)),
//                     ),
//                   ),
//                   ButtonBar(
//                     alignment: MainAxisAlignment.start,
//                     children: [
//                       FlatButton(
//                         onPressed: () {
//                           // Perform some action
//                         },
//                         child: const Text('ACTION 1'),
//                       ),
//                       FlatButton(
//                         onPressed: () {
//                           // Perform some action
//                         },
//                         child: const Text('ACTION 2'),
//                       ),
//                     ],
//                   ),
//                   Image.asset('assets/card-sample-image.jpg'),
//                 ],
//               ),
//             ),
//             Card(
//               clipBehavior: Clip.antiAlias,
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: Icon(Icons.arrow_drop_down_circle),
//                     title: const Text('Card title 1'),
//                     subtitle: Text(
//                       'Secondary Text',
//                       style: TextStyle(color: Colors.black.withOpacity(0.6)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
//                       style: TextStyle(color: Colors.black.withOpacity(0.6)),
//                     ),
//                   ),
//                   ButtonBar(
//                     alignment: MainAxisAlignment.start,
//                     children: [
//                       FlatButton(
//                         onPressed: () {
//                           // Perform some action
//                         },
//                         child: const Text('ACTION 1'),
//                       ),
//                       FlatButton(
//                         onPressed: () {
//                           // Perform some action
//                         },
//                         child: const Text('ACTION 2'),
//                       ),
//                     ],
//                   ),
//                   Image.asset('assets/card-sample-image-2.jpg'),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// IconThemeData _customIconTheme(IconThemeData original) {
//   return original.copyWith(color: shrineBrown900);
// }

// ThemeData _buildShrineTheme() {
//   final ThemeData base = ThemeData.light();
//   return base.copyWith(
//     colorScheme: _shrineColorScheme,
//     accentColor: shrineBrown900,
//     primaryColor: shrinePink100,
//     buttonColor: shrinePink100,
//     scaffoldBackgroundColor: shrineBackgroundWhite,
//     cardColor: shrineBackgroundWhite,
//     textSelectionColor: shrinePink100,
//     errorColor: shrineErrorRed,
//     buttonTheme: const ButtonThemeData(
//       colorScheme: _shrineColorScheme,
//       textTheme: ButtonTextTheme.normal,
//     ),
//     primaryIconTheme: _customIconTheme(base.iconTheme),
//     textTheme: _buildShrineTextTheme(base.textTheme),
//     primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
//     accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
//     iconTheme: _customIconTheme(base.iconTheme),
//   );
// }

// TextTheme _buildShrineTextTheme(TextTheme base) {
//   return base
//       .copyWith(
//     headline: base.headline.copyWith(
//       fontWeight: FontWeight.w500,
//       letterSpacing: defaultLetterSpacing,
//     ),
//     title: base.title.copyWith(
//       fontSize: 18,
//       letterSpacing: defaultLetterSpacing,
//     ),
//     caption: base.caption.copyWith(
//       fontWeight: FontWeight.w400,
//       fontSize: 14,
//       letterSpacing: defaultLetterSpacing,
//     ),
//     body2: base.body2.copyWith(
//       fontWeight: FontWeight.w500,
//       fontSize: 16,
//       letterSpacing: defaultLetterSpacing,
//     ),
//     body1: base.body1.copyWith(
//       letterSpacing: defaultLetterSpacing,
//     ),
//     subhead: base.subhead.copyWith(
//       letterSpacing: defaultLetterSpacing,
//     ),
//     display1: base.display1.copyWith(
//       letterSpacing: defaultLetterSpacing,
//     ),
//     button: base.button.copyWith(
//       fontWeight: FontWeight.w500,
//       fontSize: 14,
//       letterSpacing: defaultLetterSpacing,
//     ),
//   )
//       .apply(
//     fontFamily: 'Rubik',
//     displayColor: shrineBrown900,
//     bodyColor: shrineBrown900,
//   );
// }

// const ColorScheme _shrineColorScheme = ColorScheme(
//   primary: shrinePink100,
//   primaryVariant: shrineBrown900,
//   secondary: shrinePink50,
//   secondaryVariant: shrineBrown900,
//   surface: shrineSurfaceWhite,
//   background: shrineBackgroundWhite,
//   error: shrineErrorRed,
//   onPrimary: shrineBrown900,
//   onSecondary: shrineBrown900,
//   onSurface: shrineBrown900,
//   onBackground: shrineBrown900,
//   onError: shrineSurfaceWhite,
//   brightness: Brightness.light,
// );

// const Color shrinePink50 = Color(0xFFFEEAE6);
// const Color shrinePink100 = Color(0xFFFEDBD0);
// const Color shrinePink300 = Color(0xFFFBB8AC);
// const Color shrinePink400 = Color(0xFFEAA4A4);

// const Color shrineBrown900 = Color(0xFF442B2D);
// const Color shrineBrown600 = Color(0xFF7D4F52);

// const Color shrineErrorRed = Color(0xFFC5032B);

// const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
// const Color shrineBackgroundWhite = Colors.white;

// const defaultLetterSpacing = 0.03;

















































// class PostCard extends StatelessWidget {
//   const PostCard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 5 / 2,
//       child: Card(
//         child: Column(children: <Widget>[_Post(), _PostDetails()]),
//       ),
//     );
//   }
// }

// class _Post extends StatelessWidget {
//   const _Post({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 3,
//       child: Row(
//         children: <Widget>[_PostImage(), _PostTitleAndSummary()],
//       ),
//     );
//   }
// }

// class _PostTitleAndSummary extends StatelessWidget {
//   const _PostTitleAndSummary({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final TextStyle titleTheme = Theme.of(context).textTheme.headline6;
//     // final TextStyle summaryTheme = Theme.of(context).textTheme.bodyText2;
//     // final String title = DemoValues.postTitle;
//     final String summary = DemoValues.postSummary;

//     return Expanded(
//       flex: 3,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           // Text(title),
//           Text(summary),
//         ],
//       ),
//     );
//   }
// }

// class _PostImage extends StatelessWidget {
//   const _PostImage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(flex: 2, child: Image.asset(DemoValues.postImage));
//   }
// }

// class _PostDetails extends StatelessWidget {
//   const _PostDetails({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[_UserImage(), _UserNameAndEmail()],
//     );
//   }
// }

// class _UserNameAndEmail extends StatelessWidget {
//   const _UserNameAndEmail({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 7,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(DemoValues.userName),
//           // Text(DemoValues.userEmail),
//         ],
//       ),
//     );
//   }
// }

// class _UserImage extends StatelessWidget {
//   const _UserImage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 1,
//       child: CircleAvatar(
//         backgroundImage: AssetImage(DemoValues.userImage),
//       ),
//     );
//   }
// }