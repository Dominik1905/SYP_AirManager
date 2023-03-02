library dashboard;

import 'package:air_manager/app/config/routes/app_pages.dart';
import 'package:air_manager/app/shared_components/async_button.dart';
import 'package:air_manager/app/utils/services/service.dart';
import 'package:air_manager/app/config/themes/app_theme.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../../constans/app_constants.dart';
import '../../../../shared_components/header_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart%20';

import '../../../../utils/services/service.dart';

// binding
part '../../bindings/dashboard_binding.dart';

// controller
part '../../controllers/dashboard_controller.dart';

// component
part '../components/sign_out_button.dart';
part '../components/user_profile_button.dart';
part '../components/change_color_button.dart';


class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    final CollectionReference _referenceFolders = FirebaseFirestore.instance
        .collection('Daten')
        .doc(auth.currentUser!.uid)
        .collection('desired temperature');

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: kDefaultSpacing * 2),
              child: Column(
                children: [
                  const SizedBox(height: kDefaultSpacing),
                  _buildIllustration(),
                  const SizedBox(height: kDefaultSpacing),
                  _buildTitle(),
                  _buildDate(),
                  /*
                  StreamBuilder<QuerySnapshot>(
                    stream: _referenceFolders.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        //snapshot.data.docs.
                        return ListView();
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0),
                            child: Text(
                              'No Folders Yet',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),

                            child: Divider(thickness: 1.7),
                          )
                        ],
                      );
                    },
                  ),
                  */
                  const SizedBox(height: kDefaultSpacing * 1.5),
                  _buildStats(),
                  const SizedBox(height: kDefaultSpacing),
                  _buildStatisticTitle(),
                  _buildLast7Days(),
                  const SizedBox(height: kDefaultSpacing),
                  _buildStatisticsTemperature(),
                  const SizedBox(height: kDefaultSpacing),
                  _buildStatisticsHumanity(),
                  const SizedBox(height: kDefaultSpacing * 5.5),
                  _buildUserProfileButton(),
                  const SizedBox(height: kDefaultSpacing * 0.5),
                  _buildChangeColorButton(),
                  const SizedBox(height: kDefaultSpacing * 1.5),
                  _buildSignOutButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignOutButton() {
    return Obx(
      () => _SignOutButton(
        isLoading: controller.isLoading.value,
        onPressed: () => controller.signOut(),
      ),
    );
  }
  Widget _buildUserProfileButton(){
    return Obx(
          () => _UserProfileButon(
        isLoading: controller.isLoading.value,
        onPressed: () => controller.userProfile(),
      ),
    );
  }
  Widget _buildChangeColorButton(){
    return Obx(
          () => _ChangeColorButton(
        isLoading: controller.isLoading.value,
        onPressed: () => controller.changeColor(),
      ),
    );
  }
  Widget _buildTitle() {
    return const Align(
      alignment: Alignment.topCenter,
      child: HeaderText("Dashboard"),
    );
  }
  Widget _buildStatisticTitle() {
    return const Align(
      alignment: Alignment.topCenter,
      child: HeaderText("Statistic"),
    );
  }
  Widget _buildLast7Days() {
    return const Text(
      "(Last seven days)",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
  Widget _buildStats() {
    return const Text(
      "Current Temperature: 22,3°C\nCurrent Humanity: 58,7%",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
  Widget _buildStatisticsTemperature() {
    return const Text(
      "Average Temperature: 21,22°C\nHighest Temperature: 36,8°C\nLowest Temperature: -5,2°C",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
  Widget _buildStatisticsHumanity() {
    return const Text(
      "Average Humanity: 60,78%\nHighest Humanity: 80,8%\nLowest Humanity: 38,8%",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
  Widget _buildDate() {
    String formattedDate = DateFormat('dd.MM.yyyy – kk:mm').format(DateTime.now());
    formattedDate+=" Uhr";
    return Text(
      formattedDate,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
  Widget _buildIllustration() {
    return Image.asset(
      ImageRasterPath.weather,
      height: 200,
    );
  }
}

