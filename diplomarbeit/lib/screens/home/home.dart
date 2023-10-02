import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplomarbeit/screens/home/settings_form.dart';
import 'package:diplomarbeit/screens/home/user_list.dart';
import 'package:diplomarbeit/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diplomarbeit/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

import '../../models/user.dart';
import '../../models/userData.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {


    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }


    return StreamProvider<List<UserData>>.value(
      value: DatabaseService(uid:"").users,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("BodyFit"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
              ),
              icon: Icon(Icons.person),
              label: Text("logout"),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
              ),
              icon: Icon(Icons.settings),
              label: Text("settings"),
              onPressed: () => _showSettingsPanel(),
            ),
            TextButton.icon(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
              ),
              icon: Icon(Icons.surround_sound),
              label: Text("Vorlesen"),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            // falls man Hintergrund ändern will
          ),
            child: UserList()
        ),
      ),
    );
  }
}
