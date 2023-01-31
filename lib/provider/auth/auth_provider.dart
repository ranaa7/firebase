import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/user_model.dart';
import 'package:firebase/view/screens/auth/login_screen.dart';
import 'package:firebase/view/screens/chat/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  void googlesignin() async {
    final GoogleSignInAccount? googleuser = await googleSignIn.signIn();
    print(googleuser);
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleuser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    await auth.signInWithCredential(credential).then((user) {
      saveuser(user, "");
      Get.to(Chatscreen());
    });
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //Get.to(ChatScreen());
      Get.offAll(Chatscreen());
    }
    catch (e) {
      print(e);
      Get.snackbar(
          "login screen", e.toString(), snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors
              .pinkAccent); //da 3shan ytl3lna el error f el pass lw d5lnah 3'lt

    }
    //msh bn7ot notifylistener ashan msh 3yza a3ml kol shwya refresh ll sf7a du=i zy el setstate ana 3yza bs anady 3la page tanya
  }


  void signout() async {
    await auth.signOut();
    await googleSignIn.signOut();
    Get.offAll(LoginScreen());
  }

  void signup(String email, String password, String name) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password).then((user) async {
        saveuser(user, name);
      }
      );

      Get.offAll(Chatscreen());
    }
    catch (e) {
      print(e);
      Get.snackbar(  //mssg bttl3 kda ll user
          "signup screen", e.toString(), snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.pinkAccent);
    }
  }

  saveuser(UserCredential user, String name) async {
    UserModel userModel = UserModel(
        name: name == "" ?user.user!.displayName! :name ,
        email: user.user!.email!, image: "", userId: user.user!.uid);

    await firestore.collection("users").doc(user.user!.uid).set(                          //collection gowaha doc gowah collection tany or field
        userModel.toJson());
    //myzt el set 3n el add en ana mmkn ely a7dd el doc id bt3 el sh5s
  }
}
