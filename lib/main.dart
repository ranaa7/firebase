
import 'package:firebase/provider/auth/auth_provider.dart';
import 'package:firebase/provider/chat/chat_provider.dart';
import 'package:firebase/provider/chat/photo_provider.dart';
import 'package:firebase/provider/chat/splash_provider.dart';
import 'package:firebase/provider/control_provider.dart';
import 'package:firebase/view/screens/auth/login_screen.dart';
import 'package:firebase/view/screens/chat/chat_screen.dart';
import 'package:firebase/view/screens/chat/photo_screen.dart';
import 'package:firebase/view/screens/chat/splash_screen.dart';
import 'package:firebase/view/widget/control_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';







void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ChatProvider()),
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => ControlProvider()),
    ChangeNotifierProvider(create: (context) => PhotoProvider()),
    ChangeNotifierProvider(create: (context) => Splashprovider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Splashscreen(),
    );
  }
}
