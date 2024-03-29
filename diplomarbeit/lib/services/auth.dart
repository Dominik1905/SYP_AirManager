import 'package:diplomarbeit/models/user.dart';
import 'package:diplomarbeit/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService{

  // Kommunikation zwischen Firebase und App
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser

  OurUser? _userFromFirebaseUser(User? user) {
    return user != null ? OurUser(uid: user.uid) : null;

  }

  // auth change user stream
  Stream<OurUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
  }
  // sign in anonymously
  Future signInAnon() async {
    try{
      UserCredential result =  await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result =  await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData("Sehstärke", "Vorname", "Nachname", "Ausbildung", "Geburtstag (dd.mm.yyyy)", "Klasse", 0, 0);
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }


}