import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/auth/login_view.dart';

class SignUpVM extends GetxController {
  final txtEmail = TextEditingController().obs;
  final txtPassword = TextEditingController().obs;
  final txtTenDem = TextEditingController().obs;
  final txtTen = TextEditingController().obs;
  final txtSDT = TextEditingController().obs;

  final isShowPasswordLogin = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    txtTenDem.value.text = "Thanh";
    txtTen.value.text = "Thiện";
    txtEmail.value.text = "thanhthien2000@gmail.com";
    txtSDT.value.text = "0956735363";
    txtPassword.value.text = "thanhthien2000";
  }

  void serviceCallSignUp() async {
    isLoading(true);
    print(txtTenDem.value.text);
    print(txtPassword.value.text);
    await ServiceCall.post({
      "first_name": txtTenDem.value.text,
      "last_name": txtTen.value.text,
      "email": txtEmail.value.text,
      "mobile": txtSDT.value.text,
      "password": txtPassword.value.text,
      "type": "1",
      "is_superuser": "False",
      "is_staff": "False",
      "is_active": "1"
    }, SVKey.svSignUp, withSuccess: (resObj) async {
      isLoading(false);
      if (resObj[KKey.status] == 1) {
        var payload = resObj[KKey.payload] as Map? ?? {};
        Get.to(() => const LoginView(), transition: Transition.leftToRight);
        Get.snackbar("MiSa", "Bạn đã đăng kí thành công");
      }
    }, failure: (err) async {
      Get.snackbar("MiSA", err.toString());
    });
    isLoading(false);
  }

  void showPassword() {
    isShowPasswordLogin.value = !isShowPasswordLogin.value;
  }
}
