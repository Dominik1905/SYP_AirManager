import 'package:flutter/material.dart';
import 'package:diplomarbeit/models/userData.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.userData});

  final UserData userData;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
       margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.grey[400],
            backgroundImage: AssetImage("assets/profil.png"),
          ),
          title: Text(userData.firstname + " " + userData.secondname),
          subtitle: Text("Sehstärke: ${userData.eyesight}"),
        ),
      )
    );
  }
}
