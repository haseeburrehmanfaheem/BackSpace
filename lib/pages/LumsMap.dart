import 'package:flutter/material.dart';

class Map1 extends StatelessWidget {
  final _transformationController = TransformationController();
  late TapDownDetails _doubleTapDetails;
  void _handleDoubleTapDown(TapDownDetails details) {
  _doubleTapDetails = details;
}

void _handleDoubleTap() {
  if (_transformationController.value != Matrix4.identity()) {
    _transformationController.value = Matrix4.identity();
  } else {
    final position = _doubleTapDetails.localPosition;
    // For a 3x zoom
    _transformationController.value = Matrix4.identity()
      ..translate(-position.dx * 2, -position.dy * 2)
      ..scale(3.0);
    // Fox a 2x zoom
    // ..translate(-position.dx, -position.dy)
    // ..scale(2.0);
  }
}


  @override
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
          title:
              const Text('Lums Map', style: TextStyle(fontFamily: "Poppins")),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),

        body: Center(
          child: ClipRect(
            child: GestureDetector(
              // onDoubleTap: () => _handleDoubleTap(_transformationController),
              // onDoubleTapDown: _handleDoubleTapDown,
              onDoubleTapDown: _handleDoubleTapDown,
              onDoubleTap: _handleDoubleTap,
              child: InteractiveViewer(
                child: Image.asset('assets/images/Map.png'),
                transformationController: _transformationController,
              ),
            ),
            
          ),
    
        ),
          
        
      ),
    );
  }
}

