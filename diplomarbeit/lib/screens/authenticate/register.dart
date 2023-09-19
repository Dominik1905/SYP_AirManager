import 'package:diplomarbeit/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../shared/loading.dart';



class Register extends StatefulWidget {

  final toggleView;
  const Register({Key? key, void this.toggleView}) : super(key: key);


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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
        title: Text("Sign up to BodyFit"),
        actions: <Widget> [
          TextButton.icon(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
            ),
            icon: Icon(Icons.person),
            label:Text("Sign In"),
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
                obscureText: true,
                validator: (val) => val!.length < 6 ? "Enter a password 6+ chars long" : null,
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
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formkey.currentState!.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = "please supply valid email";
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
