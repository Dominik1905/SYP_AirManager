part of user_profile;


class UserProfileController extends GetxController with ValidatorMixin {
  final name = TextEditingController();
  final telephonenumber = TextEditingController();
  final adress = TextEditingController();
  final temperature = TextEditingController();
  final auth = AuthService();

  final CollectionReference _daten = FirebaseFirestore.instance.collection("Daten");


  final isLoading = false.obs;


  void changeUserSettings() async {
    if(name.text.isEmpty && telephonenumber.text.isEmpty && adress.text.isEmpty){
    }else{
      try {
        await _daten.doc(auth.currentUser?.uid).delete();
        await _daten.doc(auth.currentUser?.uid).set({"name": name.text, "number": telephonenumber.text, "adress": adress.text, "desired temperature": temperature.text}).then((value)=> print("User Profile added!"));
      } catch (error) {
        AppSnackbar.showMessage("Problem!");
      }
    }
      isLoading.value = false;
    goToDashboard();
    }
  void goToDashboard() => Get.offAllNamed(Routes.dashboard);
  }

