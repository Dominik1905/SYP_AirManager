import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplomarbeit/models/user.dart';
import 'package:diplomarbeit/models/userData.dart';

class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userDataCollection = FirebaseFirestore.instance.collection("users");

  Future updateUserData(String eyesight, String firstname, String secondname, String education, String dateOfBirth, String schoolClass, double usedWeightBarbell, double weeklyGoal) async {
    return await userDataCollection.doc(uid).set({
        "eyesight": eyesight,
        "firstname": firstname,
        "secondname": secondname,
        "education": education,
        "dateOfBirth": dateOfBirth,
        "schoolClass": schoolClass,
        "usedWeightBarbell": usedWeightBarbell,
        "weeklyGoal": weeklyGoal
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
        dateOfBirth: doc.get("dateOfBirth") ?? "",
        schoolClass: doc.get("schoolClass") ?? "",
        usedWeightBarbell: doc.get("usedWeightBarbell") ?? "",
          weeklyGoal: doc.get("weeklyGoal") ?? ""
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
        snapshot.get("education"),
        snapshot.get("dateOfBirth"),
        snapshot.get("schoolClass"),
        snapshot.get("usedWeightBarbell"),
        snapshot.get("weeklyGoal")
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