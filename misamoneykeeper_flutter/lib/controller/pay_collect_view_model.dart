import 'package:intl/intl.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class PayCollectViewModel extends GetxController {
  var categoryIcon = ''.obs;
  var categoryTitle = ''.obs;
  var categoryDetailsId = 0.obs;
  var isLoading = false.obs;

  // Tài khoản
  var accountIcon = ''.obs;
  var accountTitle = ''.obs;
  var accountId = 0.obs;

  final dateController = TextEditingController(
          text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
      .obs;

  final moneyAccount = TextEditingController().obs;
  final descriptionAccount = TextEditingController().obs;

  final splashVM = Get.find<SplashViewModel>();

  @override
  void dispose() {
    super.dispose();
    clean();
  }

  void serviceAddPay() async {
    isLoading(true);
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
      "category_details_id": categoryDetailsId.value.toString(),
      "account_id": accountId.value.toString(),
      "p_type": 2.toString(),
      "p_money": moneyAccount.value.text,
      "p_explanation": descriptionAccount.value.text,
      "p_date": dateController.value.text
    }, SVKey.svAddPlay, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        clean();
        Get.snackbar(appname, "Bạn đã thêm khoản thu thành công");
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }

  void clean() {
    categoryIcon.value = '';
    categoryTitle.value = '';
    categoryDetailsId.value = 0;
    isLoading(false);
    accountIcon.value = '';
    accountTitle.value = '';
    accountId.value = 0;
    dateController.value.text = '';
    moneyAccount.value.text = '';
    descriptionAccount.value.text = '';
  }
}
