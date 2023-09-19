import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplomarbeit/models/user.dart';
import 'package:diplomarbeit/models/userData.dart';

class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userDataCollection = FirebaseFirestore.instance.collection("users");

  Future updateUserData(String eyesight, String firstname, String secondname, String education) async {
    return await userDataCollection.doc(uid).set({
        "eyesight": eyesight,
        "firstname": firstname,
        "secondname": secondname,
        "education": education,
      });
  }

  // user list from snapshot
  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return UserData(
        firstname: doc.get("firstname") ?? "",
        secondname: doc.get("secondname") ?? "",
        eyesight: doc.get("eyesight") ?? "",
        education: doc.get("education") ?? "",
      );
    }).toList();
  }

  // userDataModell from snapshot
  UserDataModell _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserDataModell(
        uid,
        snapshot.get("firstname"),
        snapshot.get("secondname"),
        snapshot.get("eyesight"),
        snapshot.get("education")
    );

  }
  
  // get users stream
  Stream<List<UserData>> get users {
    return userDataCollection.snapshots()
    .map(_userListFromSnapshot);
  }

  // get user doc stream
  Stream<UserDataModell> get userData {
    return userDataCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}