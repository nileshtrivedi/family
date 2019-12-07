import 'package:family/message_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'family.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: ChatDetails(),
    );
  }
}



class ChatDetails extends StatefulWidget {
  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  final TextEditingController _textController = new TextEditingController();

  void _handleSubmitted(String text){
    _textController.clear();
    // push message to firestore and call setState() ?
    return;
    final DocumentReference postRef = Firestore.instance.collection('families').document(familyId);
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(postRef);
      if (postSnapshot.exists) {
        Object msg = {'content': text, 'sender': myId, 'type': 'chat', 'timestamp': ''};
        await tx.update(postRef, <String, dynamic>{'messages': postSnapshot.data['messages'] + msg});
      }
    });
  }

  Widget _buildTextComposer(){
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new TextField(
        controller: _textController,
        onSubmitted: _handleSubmitted,
        decoration: new InputDecoration.collapsed(
            hintText: "Send a message"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/105'),
                backgroundColor: Colors.grey[200],
                minRadius: 30,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StreamBuilder(
                  stream: Firestore.instance.collection('families').snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData) return const Text('Loading...');
                    return Text(
                      snapshot.data.documents[0]['members'][0]['name'],
                      style: TextStyle(color: Colors.black),
                    );
                  },
                ),
                Text(
                  'Online Now',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: new MessageList()
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(-2, 0),
                  blurRadius: 5,
                ),
              ]),
              child: Row(
                children: <Widget>[
                  /* IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera,
                      color: Color(0xff3E8DF3),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.image,
                      color: Color(0xff3E8DF3),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                  ),*/
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Send a message',
                        border: InputBorder.none,
                      ),
                      controller: _textController,
                      onSubmitted: _handleSubmitted
                    ),
                  ),
                  IconButton(
                    onPressed: () => _handleSubmitted(_textController.text),
                    icon: Icon(
                      Icons.send,
                      color: Color(0xff3E8DF3),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

