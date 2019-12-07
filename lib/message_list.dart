import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'family.dart';
import 'bubble.dart';

class MessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.collection('families').document(familyId).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data['messages'].map<Widget>((obj) {
                return new Bubble(
                  message: obj['content'],
                  isMe: (obj['sender'] == myId)
                );
              }).toList(),
            );
        }
      },
    );
  }
}