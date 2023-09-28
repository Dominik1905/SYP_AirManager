import 'package:diplomarbeit/models/user.dart';
import 'package:diplomarbeit/services/database.dart';
import 'package:diplomarbeit/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:diplomarbeit/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formkey = GlobalKey<FormState>();
  final List<String> eyesights = ["Stark", "Mittel", "Schwach"];
  final List<String> educations = ["Lehrer", "Schüler"];
  final List<String> classes = ["1A", "2A", "3A", "4A"];

  // form values
  String? _currentFirstname;
  String? _currentSecondname;
  String? _currentEyesight;
  String? _currentEducation;
  String? _currentdateOfBirth;
  String? _currentschoolClass;
  double? _currentusedWeightBarbell;
  double? _currentweeklyGoal;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<OurUser?>(context);

    return StreamBuilder<UserDataModell>(
      stream: DatabaseService(uid: user!.uid!).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserDataModell? userDataModell = snapshot.data;
          return Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    "Aktualisiere deine Daten.",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: userDataModell?.firstname),
                    onChanged: (val) => setState(()=>_currentFirstname = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: userDataModell?.secondname),
                    onChanged: (val) => setState(()=>_currentSecondname = val),
                  ),
                  SizedBox(height: 20.0),
                  // dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration.copyWith(hintText: _currentEyesight ?? userDataModell?.eyesight),
                    items: eyesights.map((sight){
                      return DropdownMenuItem(
                        value: sight,
                        child: Text(sight),
                      );
                    }).toList(),
                    onChanged: (val) => setState(()=>_currentEyesight = val!),
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    decoration: textInputDecoration.copyWith(hintText: _currentEducation ?? userDataModell?.education),
                    items: educations.map((edu){
                      return DropdownMenuItem(
                        value: edu,
                        child: Text(edu),
                      );
                    }).toList(),
                    onChanged: (val) => setState(()=>_currentEducation = val!),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: userDataModell?.dateOfBirth),
                    onChanged: (val) => setState(()=>_currentdateOfBirth = val),
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    decoration: textInputDecoration.copyWith(hintText: _currentschoolClass ?? userDataModell?.schoolClass),
                    items: classes.map((edu){
                      return DropdownMenuItem(
                        value: edu,
                        child: Text(edu),
                      );
                    }).toList(),
                    onChanged: (val) => setState(()=>_currentschoolClass = val!),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: userDataModell?.usedWeightBarbell == 0 ? "Gewicht auf Langhantel" : userDataModell?.usedWeightBarbell.toString()),
                    onChanged: (val) => setState(()=>_currentusedWeightBarbell = double.tryParse(val)),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: userDataModell?.weeklyGoal == 0 ? "Wochenziel in Stunden" : userDataModell?.weeklyGoal.toString()),
                    onChanged: (val) => setState(()=>_currentweeklyGoal = double.tryParse(val)),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.pink)
                    ),
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formkey.currentState!.validate()){
                        await DatabaseService(uid: user.uid!).updateUserData(
                            _currentEyesight ?? userDataModell!.eyesight,
                            _currentFirstname ?? userDataModell!.firstname,
                            _currentSecondname ?? userDataModell!.secondname,
                            _currentEducation ?? userDataModell!.education,
                            _currentdateOfBirth ?? userDataModell!.dateOfBirth,
                            _currentschoolClass ?? userDataModell!.schoolClass,
                            _currentusedWeightBarbell ?? userDataModell!.usedWeightBarbell,
                            _currentweeklyGoal ?? userDataModell!.weeklyGoal
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              )
            ),
          );
        } else {
          return Loading();
        }

      }
    );
  }
}
