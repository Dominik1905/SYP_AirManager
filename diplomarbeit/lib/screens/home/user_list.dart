import 'package:diplomarbeit/screens/home/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diplomarbeit/models/userData.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<UserData>>(context) ?? [];

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserTile(userData: users[index]);
      },
    );
  }
}
