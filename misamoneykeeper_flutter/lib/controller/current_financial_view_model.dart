import 'dart:async';

import 'package:misamoneykeeper_flutter/model/report_account.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class CurrentFinancialViewModel extends GetxController {
  CurrentFinancialViewModel() {
    serviceCallList();
  }

  // //ServiceCall
  StreamController<List<ReportAccount>> streamController =
      StreamController<List<ReportAccount>>();
  void serviceCallList() async {
    await ServiceCall.post({
      "user_id": "2",
    }, SVKey.svReportAccount, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        var data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return ReportAccount.fromJson(oObj);
        }).toList();
        streamController.add(data);
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }

  // // Lắng nghe sự thay đổi của streamController
  Stream<List<ReportAccount>?> get dataStream => streamController.stream;
}
