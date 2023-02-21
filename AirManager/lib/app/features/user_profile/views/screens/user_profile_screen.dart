library user_profile;

import 'package:air_manager/app/config/routes/app_pages.dart';
import 'package:air_manager/app/constans/app_constants.dart';
import 'package:air_manager/app/shared_components/async_button.dart';
import 'package:air_manager/app/shared_components/header_text.dart';
import 'package:air_manager/app/utils/mixins/app_mixins.dart';
import 'package:air_manager/app/utils/services/service.dart';
import 'package:air_manager/app/utils/ui/ui_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart%20';




part '../../bindings/user_profile_bindings.dart';

// controller
part '../../controllers/user_profile_controller.dart';

// component
part '../components/button/submit_button.dart';
part '../components/button/go_to_dashboard.dart';
part '../components/text_field/name_text_field.dart';
part '../components/text_field/telephonenumber_text_field.dart';
part '../components/text_field/adress_text_field.dart';
part '../components/text_field/desired_room_temperature.dart';

class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultSpacing * 2),
                  child: Column(
                    children: [
                      const SizedBox(height: kDefaultSpacing),
                      _buildIllustration(),
                      const SizedBox(height: kDefaultSpacing),
                      _buildTitle(),
                      const SizedBox(height: kDefaultSpacing * 1.5),
                      _NameTextField(controller: controller.name),
                      const SizedBox(height: kDefaultSpacing),
                      _TelephonenumberTextField(controller: controller.telephonenumber),
                      const SizedBox(height: kDefaultSpacing),
                      _AdressTextFiel(controller: controller.adress),
                      const SizedBox(height: kDefaultSpacing * 1.5),
                      _DesiredRoomTemperature(controller: controller.temperature),
                      const SizedBox(height: kDefaultSpacing),
                      const Spacer(),
                      _buildSubmitButton(),
                      const SizedBox(height: kDefaultSpacing),
                      const SizedBox(height: kDefaultSpacing),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.all(kDefaultSpacing / 2),
              child: BackButton(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    return Image.asset(
      ImageRasterPath.form,
      height: 200,
    );
  }

  Widget _buildTitle() {
    return const Align(
      alignment: Alignment.topLeft,
      child: HeaderText("User Profile"),
    );
  }
  Widget _buildSubmitButton() {
    return Obx(
          () => _SubmitButton(
            isLoading: controller.isLoading.value,
            onPressed: () => controller.changeUserSettings(),
      ),
    );
  }
}


