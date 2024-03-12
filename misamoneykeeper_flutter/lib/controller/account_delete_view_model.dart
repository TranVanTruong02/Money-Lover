import 'package:misamoneykeeper_flutter/controller/account_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class AccountDeleteViewModel extends GetxController {
  final splashVM = Get.find<SplashViewModel>();
  final accountViewModel = Get.find<AccountViewModel>();
  var isLoading = false.obs;
  var isSuccess = false.obs;

  final int accountId;
  AccountDeleteViewModel(this.accountId);

  void serviceCallAccountDelete() async {
    isLoading(true);
    await ServiceCallDelete.delete({
      "account_id": accountId.toString(),
      "user_id": splashVM.userModel.value.id.toString()
    }, SVKey.svDeleteAccount, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        isLoading(false);
        accountViewModel.serviceCallList();
        Get.snackbar(appname, "Bạn đã xóa tài khoản thành công");
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }
}
