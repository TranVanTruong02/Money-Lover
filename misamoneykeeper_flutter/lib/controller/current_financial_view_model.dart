import 'package:flutter/foundation.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/report_account.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class CurrentFinancialViewModel extends GetxController {
  final splashVM = Get.find<SplashViewModel>();
  final RxList<ReportAccount> arrayReportAccount = <ReportAccount>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print("Ban đầu: CurrentFinancialViewModel");
    }
    service();
  }

  //ServiceCall
  void service() {
    isLoading(true);
    ServiceCall.post({
      "user_id": "1",
    }, SVKey.svReportAccount, isToken: true, withSuccess: (resObj) async {
      isLoading(false);
      if (resObj[KKey.status] == 1) {
        var data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return ReportAccount.fromJson(oObj);
        }).toList();

        arrayReportAccount.value = data;
      } else {}
    }, failure: (err) async {
      isLoading(false);
      Get.snackbar(appname, err.toString());
    });
  }
}
