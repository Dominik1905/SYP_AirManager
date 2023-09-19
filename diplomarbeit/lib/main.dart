import 'package:diplomarbeit/models/user.dart';
import 'package:diplomarbeit/screens/wrapper.dart';
import 'package:diplomarbeit/services/auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Um die App mit Firebase zu verbinden
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<OurUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        // Home screen variert nach der Entscheidung der Wrapper Klasse
        home: Wrapper(),
      ),
    );
  }
}
