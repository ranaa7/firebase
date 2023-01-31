import 'package:firebase/provider/chat/chat_provider.dart';
import 'package:firebase/provider/chat/photo_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Photoscreen extends StatelessWidget {
  const Photoscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PhotoProvider>(context,listen: false);
    var chatprovider=Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("Photo's screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(chatprovider.userModel.image == ""?
                  "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png"
              :chatprovider.userModel.image),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      provider.getImage(ImageSource.gallery);
                    },
                    child: const Text('add image from gallery')),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                    onPressed: () {
                      provider.getImage(ImageSource.camera);
                    },
                    child: const Text('add image from camera')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
