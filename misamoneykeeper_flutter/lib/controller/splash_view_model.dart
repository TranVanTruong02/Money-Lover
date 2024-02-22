import 'package:misamoneykeeper_flutter/model/user_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/auth/login_view.dart';
import 'package:misamoneykeeper_flutter/view/report/report_view.dart';

class SplashViewModel extends GetxController {
  final userModel = UserModel().obs;

  void loadView() async {
    await Future.delayed(const Duration(seconds: 3));

    if (Globs.udValueBool(Globs.userLogin)) {
      userModel.value = UserModel.fromJson(Globs.udValue(Globs.userPayload));
      Get.to(() => const ReportView());
    } else {
      Get.to(() => const LoginView());
    }
  }

  void goAfterLoginMainTab() {
    userModel.value = UserModel.fromJson(Globs.udValue(Globs.userPayload));
    Get.to(() => const ReportView());
  }

  void setData() {
    userModel.value = UserModel.fromJson(Globs.udValue(Globs.userPayload));
  }

  void logout() {
    userModel.value = UserModel();
    Globs.udBoolSet(false, Globs.userLogin);
    Get.to(() => const LoginView());
  }
}
