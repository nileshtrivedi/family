import 'package:family/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:family/chat_details.dart';
import 'package:family/map_view.dart';

class TopTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.group)),
                Tab(icon: Icon(Icons.location_on)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
            title: Text('Family'),
          ),
          body: TabBarView(
            children: [
              ChatDetails(),
              MapView(),
              SettingsView(),
            ],
          ),
        ),
      ),
    );
  }
}