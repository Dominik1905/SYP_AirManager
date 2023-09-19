import 'package:diplomarbeit/models/user.dart';
import 'package:diplomarbeit/screens/authenticate/authenticate.dart';
import 'package:diplomarbeit/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<OurUser?>(context);

    // return either Home or Authenticate widget
    if(user==null){
      return Authenticate();
    } else{
      return Home();
    }
  }
}