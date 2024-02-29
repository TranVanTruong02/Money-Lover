import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/report_account.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class CurrentFinancialViewModel extends GetxController {
  final splashVM = Get.find<SplashViewModel>();

  //ServiceCall
  Future<List<ReportAccount>> serviceCallList() async {
    List<ReportAccount> data = [];
    await ServiceCall.post({
      "user_id": "2",
    }, SVKey.svReportAccount, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return ReportAccount.fromJson(oObj);
        }).toList();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
    return data;
  }
}
