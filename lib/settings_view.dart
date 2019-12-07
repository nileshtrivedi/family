import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return ListView(
      children: [
        ListTile(
          selected:true,
          leading: Icon(Icons.file_download),
          title: Text("Documents"),
          onTap: (){},
        ),
        ListTile(
          selected:true,
          leading: Icon(Icons.add),
          title: Text("Add Member"),
          onTap: (){},
        ),
        ListTile(
          selected:true,
          leading: Icon(Icons.lock),
          title: Text("OTP sharing"),
          onTap: (){},
        ),
        ListTile(
          selected:true,
          leading: Icon(Icons.location_on),
          title: Text("Location sharing"),
          onTap: (){},
        ),
        ListTile(
          selected:true,
          leading: Icon(Icons.calendar_today),
          title: Text("Calendar sharing"),
          onTap: (){},
        ),
        ListTile(
          selected:true,
          leading: Icon(Icons.info_outline),
          title: Text("About this app"),
          onTap: (){},
        ),
      ],
    );
  }
}