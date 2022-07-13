import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  double _opacity = 1;
  double _size = 600;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(
        milliseconds: 1000,
      ),
      (timer) {
        setState(() {
          _opacity = _opacity == 1 ? 0.5 : 1;
          _size = _size == 300 ? 450 : 300;
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedContainer(
          curve: Curves.linear,
          alignment: Alignment.center,
          width: _size,
          duration: const Duration(milliseconds: 800),
          child: AnimatedOpacity(
            curve: Curves.linear,
            duration: const Duration(milliseconds: 800),
            opacity: _opacity,
            child: Image.asset(
              'assets/images/dazzle.png',
            ),
          ),
        ),
      ),
    );
  }
}
