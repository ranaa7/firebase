import 'package:firebase/provider/control_provider.dart';
import 'package:firebase/view/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/auth/login_screen.dart';

class ControlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ControlProvider>(builder: (context,provider,child){
      return provider.uId==null? LoginScreen():Chatscreen();
    });
  }
}
