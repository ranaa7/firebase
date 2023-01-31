import 'dart:async';

import 'package:firebase/view/screens/auth/login_screen.dart';
import 'package:firebase/view/widget/control_view.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => ControlView()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(  backgroundColor: Colors.pinkAccent,
      body: Center(
        child: Image.asset('assets/chatlogo.png'),
      ),  );
  }
}