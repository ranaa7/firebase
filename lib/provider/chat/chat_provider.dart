import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/chat_model.dart';
import 'package:firebase/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ChatProvider extends ChangeNotifier {

FirebaseFirestore firestore=FirebaseFirestore.instance;

FirebaseAuth auth = FirebaseAuth.instance;

UserModel userModel=UserModel(name: "", email: "", image: "", userId: "");

Stream<List<ChatModel>>getChatstream(){  //tgeb kol el mssg ely mt5zna f el firestore
  return firestore.collection("chat").orderBy("time",descending: true)
      .snapshots().map((event) {
    return List<ChatModel>.from(event.docs.map((e) => ChatModel.fromJson(e.data())));
  });
}
sendmssg(ChatModel chatModel)async{  //bnktb hna el mssg ely htro7 f el firestore
  await firestore.collection("chat").add(chatModel.toJson());
}
getuser()async{      //bngeb el userdata ashan a3rf men ely katb el mssg mn el firestore brdo
  await firestore.collection("users").doc(auth.currentUser!.uid).get().then((value) {
   userModel= UserModel.fromJson(value.data()!);
   notifyListeners();
  });
}
}
