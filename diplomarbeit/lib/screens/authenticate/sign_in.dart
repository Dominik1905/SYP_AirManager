import 'package:diplomarbeit/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../shared/constants.dart';
import '../../shared/loading.dart';


class SignIn extends StatefulWidget {

  final toggleView;
  const SignIn({Key? key, void this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  // Kommunikation Directory: services/auth.dart
  final AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  // text fiel state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign in to BodyFit"),
        actions: <Widget> [
          TextButton.icon(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
            ),
            icon: Icon(Icons.person),
            label:Text("Register"),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (val) => val!.isEmpty ? "Enter an email" : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (val) => val!.length < 6 ? "Enter a password 6+ chars long" : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pink)
                ),
                child: Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formkey.currentState!.validate()) {
                    setState(()=> loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = "could not sign in";
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
