import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoProvider extends ChangeNotifier {
final ImagePicker picker=ImagePicker();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseStorage storage= FirebaseStorage.instance;
FirebaseFirestore firestore=FirebaseFirestore.instance;



void getImage(ImageSource src) async {
  final XFile? pickedImageFile = await picker.pickImage(source: src,imageQuality: 50,maxWidth: 100,maxHeight: 100);

  if(pickedImageFile !=null){
    File pickImage = File(pickedImageFile.path);

    await storage.ref().child(auth.currentUser!.uid + ".jpg").putFile(pickImage);

    final url = await storage.ref().child(auth.currentUser!.uid + '.jpg').getDownloadURL();

    await firestore.collection("users").doc(auth.currentUser!.uid).update({
      "image": url
    });

    firestore.collection("chat").where("uId", isEqualTo: auth.currentUser!.uid).get().then((value) {
      value.docs.forEach((element) {
        firestore.collection("chat").doc(element.id).update({"avatarUrl": url});
      });
    });


    notifyListeners();

  }else{
    print("image not found");
  }
}

}