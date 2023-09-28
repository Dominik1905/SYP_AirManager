import 'dart:ffi';

class OurUser {

  final String? uid;

  OurUser({this.uid});

}

class UserDataModell {

  final String uid;
  final String firstname;
  final String secondname;
  final String eyesight;
  final String education;
  final String dateOfBirth;
  final String schoolClass;
  final double usedWeightBarbell;
  final double weeklyGoal;

  UserDataModell(this.uid, this.firstname, this.secondname, this.eyesight, this.education, this.dateOfBirth, this.schoolClass, this.usedWeightBarbell, this.weeklyGoal);

}