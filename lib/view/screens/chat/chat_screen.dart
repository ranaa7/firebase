import 'package:firebase/models/chat_model.dart';
import 'package:firebase/provider/chat/chat_provider.dart';
import 'package:firebase/view/screens/chat/photo_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth/auth_provider.dart';

class Chatscreen extends StatelessWidget {
  Chatscreen({Key? key}) : super(key: key);
  var text = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Provider.of<ChatProvider>(context).getuser();
    var userprovider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff075E54),
        title: GestureDetector(
          onTap: () {
            Get.to(Photoscreen());
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png"),
              ),
              SizedBox(
                width: 10,
              ),
              Text("hossam"),
            ],
          ),
        ),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () {
                  Provider.of<AuthProvider>(context, listen: false).signout();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Logout'),
                  ],
                ),
              ),
            ];
          })
        ],
      ),
      body: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: StreamBuilder<List<ChatModel>>(   //hnst3ml stream builder da bdyl llnotifylistener ashan da msh m7tagen n3ml run da bytgdd kda lw7do lakn el notify bn7tag ndos run as enha zy el setstate
                  stream: Provider.of<ChatProvider>(context).getChatstream(),
                  builder: (context, snapshot) {
                    // snapshot.data;

                    List<ChatModel> chatlist = snapshot.data ?? [];

                    return ListView.builder(
                        reverse: true,
                        itemCount: chatlist.length,
                        itemBuilder: (context, index) {
                          bool isme = chatlist[index].userId == user!.uid;
                          return isme
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.lightGreenAccent),
                                      child: Column(
                                        children: [
                                          Text(chatlist[index].name),
                                          Text(chatlist[index].message)
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
                                        backgroundImage: NetworkImage(chatlist[
                                                        index]
                                                    .avatarUrl ==
                                                ""
                                            ? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png"
                                            : chatlist[index].avatarUrl)),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      child: Icon(Icons.account_circle_sharp),
                                    ),
                                    Container(
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      child: Column(
                                        children: [
                                          Text(chatlist[index].name),
                                          Text(chatlist[index].message)
                                        ],
                                      ),
                                    )
                                  ],
                                );
                        });
                  }),
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: text,
                  decoration: InputDecoration(
                    hintText: "Enter a message",
                    //  suffixIcon: IconButton(icon: Icon(Icons.send),
                    // onPressed: (){
                    //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Photoscreen()));
                    // },
                    //    ),
                  ),
                )),
                FloatingActionButton(
                  onPressed: () async {
                    await Provider.of<ChatProvider>(context, listen: false)
                        .sendmssg(ChatModel(
                            userId: userprovider.userModel.userId,
                            name: userprovider.userModel.name,
                            message: text.text,
                            time: DateTime.now().toString(),
                            avatarUrl: userprovider.userModel.image));
                    text.clear();
                    FocusScope.of(context).unfocus();

                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Photoscreen()));
                  },
                  child: Icon(Icons.send),
                )
              ],
            )
          ]),
    );
  }
}
